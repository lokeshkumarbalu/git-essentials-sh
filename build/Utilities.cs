namespace build;

using JetBrains.Annotations;
using SimpleExec;

[PublicAPI]
public static class Utilities
{
    public static void EnsureDirectoryDeleted(string path)
    {
        if (!Directory.Exists(path)) return;
        var dir = new DirectoryInfo(path);
        DeleteDirectory(dir);
    }

    private static void DeleteDirectory(DirectoryInfo baseDir)
    {
        baseDir.Attributes = FileAttributes.Normal;
        foreach (var childDir in baseDir.GetDirectories())
            DeleteDirectory(childDir);

        foreach (var file in baseDir.GetFiles())
            file.IsReadOnly = false;

        baseDir.Delete(true);
    }

    public static void EnsureDirectories(string path)
    {
        if (Directory.Exists(path)) return;
        Console.WriteLine($"Creating directory {path}");
        Directory.CreateDirectory(path);
    }


    public static void DotNetToolRestore() =>
        Command.Run("dotnet", "tool restore");
    
    public static void CopyShellScriptsToGit(string source, string destination)
    {
        var sourceDir = new DirectoryInfo(source);
        var destinationDir = new DirectoryInfo(destination);
        if (!sourceDir.Exists)
        {
            Console.WriteLine($"Source directory {source} does not exist");
            return;
        }

        if (!destinationDir.Exists)
        {
            Console.WriteLine($"Destination directory {destination} does not exist");
            return;
        }

        var files = sourceDir.GetFiles("*.sh");
        foreach (var file in files)
        {
            var destFile = Path.Combine(destination, file.Name);
            Console.WriteLine($"Copying {file.FullName} to {destFile}");
            file.CopyTo(destFile, true);
        }
    }
}