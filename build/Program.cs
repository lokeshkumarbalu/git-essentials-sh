using build;
using Bullseye;

const string outputFolder = "output";
const string gitInstallationPath = @"C:\Program Files\Git\usr\bin";

Targets.Target(Operation.Clean, Targets.ForEach(outputFolder), Utilities.EnsureDirectoryDeleted);
Targets.Target(Operation.CreateFolders, Targets.ForEach(outputFolder), Utilities.EnsureDirectories);
Targets.Target(Operation.InitialiseFolders, Targets.DependsOn(Operation.Clean, Operation.CreateFolders));

Targets.Target(Operation.CopyShellScripts, () => Utilities.CopyShellScriptsToGit("src", gitInstallationPath));
Targets.Target(Operation.Default, Targets.DependsOn(Operation.InitialiseFolders));
await Targets.RunTargetsAndExitAsync(args);

internal static class Operation
{
    public const string Clean = "clean";
    
    public const string CreateFolders = "create-folders";
    
    public const string InitialiseFolders = "initialise-folders";
    
    public const string Default = "default";
    
    public const string CopyShellScripts = "copy-shell-scripts";
}