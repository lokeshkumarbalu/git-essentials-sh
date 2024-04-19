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
}