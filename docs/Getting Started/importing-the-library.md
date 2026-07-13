# Importing the Library

## Over HTTP

!!! note
    This will only work if the environment you are in supports `loadstring`.

!!! warning
    If you are always importing from the latest release you could be subject to deprecation and other changes.

This method will download the library dynamically using `loadstring` & `HttpGet`.

=== "Latest"
    ```luau
    local UnAlive = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
    ))()
    ```

=== "Cached loading"
    !!! warning
        `writefile`, `readfile`, and `makefolder` (or equivalent filesystem functions) must be supported in your environment for this method to work.

    ```luau
    local function importCached(owner, repo, branch, file)
        local url = ("https://raw.githubusercontent.com/%s/%s/%s/%s"):format(owner, repo, branch, file)

        local cacheFolder = ".cache"
        if not isfolder(cacheFolder) then
            makefolder(cacheFolder)
        end

        local cacheFile = file:gsub("[^%w%-_%.]", "-")
        local cachePath = ("%s/%s-%s"):format(cacheFolder, branch, cacheFile)

        if not isfile(cachePath) then
            writefile(cachePath, game:HttpGetAsync(url))
        end

        return loadstring(readfile(cachePath), file)()
    end

    local UnAlive = importCached("UnAliveScripts", "unaliveui", "main", "src/init.luau")
    ```

## Local Build

1. Download a valid release from: [UnAlive Releases](https://github.com/UnAliveScripts/unaliveui/releases)
2. Place the `luau` module into your project (e.g., under `packages/`).

## Building From Source

Proceed to [Building From Source](./building-from-source.md)
