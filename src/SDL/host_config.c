#define _CRT_SECURE_NO_WARNINGS

#include "host_config.h"

#include "revenge/debug.h"

#include <SDL3/SDL_filesystem.h>

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef _WIN32
#include <direct.h>
#define CHANGE_DIRECTORY _chdir
#else
#include <unistd.h>
#define CHANGE_DIRECTORY chdir
#endif

enum
{
	HOST_PATH_CAPACITY = 0x1000,
	CONFIG_LINE_CAPACITY = 0x1000
};

static char *TrimWhitespace(char *text)
{
	char *end;

	while (*text != '\0' && isspace((unsigned char) *text))
		++text;
	end = text + strlen(text);
	while (end != text && isspace((unsigned char) end[-1]))
		--end;
	*end = '\0';
	return text;
}

static int IsAbsolutePath(const char *path)
{
	if (path[0] == '/' || path[0] == '\\')
		return 1;
	return isalpha((unsigned char) path[0]) && path[1] == ':';
}

static int JoinPath(
	char destination[HOST_PATH_CAPACITY],
	const char *basePath,
	const char *relativePath)
{
	int written;

	written = snprintf(destination, HOST_PATH_CAPACITY,
		"%s%s", basePath, relativePath);
	return written >= 0 && written < HOST_PATH_CAPACITY;
}

static int ReadConfiguredAssetDirectory(
	const char *configPath,
	char assetDirectory[HOST_PATH_CAPACITY])
{
	FILE *configFile;
	char line[CONFIG_LINE_CAPACITY];

	configFile = fopen(configPath, "r");
	if (configFile == NULL)
		return 0;
	while (fgets(line, sizeof(line), configFile) != NULL)
	{
		char *equals;
		char *key;
		char *value;

		key = TrimWhitespace(line);
		if (*key == '\0' || *key == '#' || *key == ';')
			continue;
		equals = strchr(key, '=');
		if (equals == NULL)
			continue;
		*equals = '\0';
		value = TrimWhitespace(equals + 1);
		key = TrimWhitespace(key);
		if (strcmp(key, "asset_directory") != 0)
			continue;
		if (*value == '\0' || strlen(value) >= HOST_PATH_CAPACITY)
			break;
		strcpy(assetDirectory, value);
		fclose(configFile);
		return 1;
	}
	fclose(configFile);
	return -1;
}

int SDLHost_ConfigureAssetDirectory(void)
{
	const char *basePath;
	const char *environmentPath;
	char configPath[HOST_PATH_CAPACITY];
	char configuredPath[HOST_PATH_CAPACITY];
	char resolvedPath[HOST_PATH_CAPACITY];
	int configResult;

	environmentPath = getenv("REVENGE_ASSET_DIRECTORY");
	basePath = SDL_GetBasePath();
	if (environmentPath != NULL && *environmentPath != '\0')
	{
		if (strlen(environmentPath) >= sizeof(resolvedPath))
		{
			fprintf(stderr, "Asset directory path is too long.\n");
			return 0;
		}
		strcpy(resolvedPath, environmentPath);
	}
	else
	{
		/* No configuration preserves the caller's working directory, matching
		 * the original DOS launch and the pre-package launcher behavior. */
		if (basePath == NULL ||
			!JoinPath(configPath, basePath, "REVENGE.CFG"))
			return 1;
		configResult = ReadConfiguredAssetDirectory(
			configPath, configuredPath);
		if (configResult == 0)
			return 1;
		if (configResult < 0)
		{
			fprintf(stderr,
				"REVENGE.CFG does not contain a valid asset_directory.\n");
			return 0;
		}
		if (IsAbsolutePath(configuredPath))
			strcpy(resolvedPath, configuredPath);
		else if (!JoinPath(resolvedPath, basePath, configuredPath))
		{
			fprintf(stderr, "Configured asset directory path is too long.\n");
			return 0;
		}
	}

	if (CHANGE_DIRECTORY(resolvedPath) != 0)
	{
		fprintf(stderr, "Cannot open original-game asset directory: %s\n",
			resolvedPath);
		return 0;
	}
	RevengeTrace("entry: asset directory=%s\n", resolvedPath);
	return 1;
}
