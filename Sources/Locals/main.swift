import Foundation
import CommandLineKit
import Rainbow
import LocalsKit

let cli = CommandLineKit.CommandLine()

let projectOption = StringOption(shortFlag: "p",
                                 longFlag: "project",
                                 helpMessage: "Path to the output file.")

let excludedPaths = MultiStringOption(shortFlag: "e",
                      longFlag: "exclude",
                      helpMessage: "Prints a help message.")

let help = BoolOption(shortFlag: "h",
                      longFlag: "help",
                      helpMessage: "Prints a help message.")

cli.addOptions(projectOption, help)

cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
        break
    case .optionFlag:
        str = s.green.underline
        break
    case .optionHelp:
        str = s.lightBlue
        break
    default:
        str = s
        break
    }
    return cli.defaultFormat(s: str, type: type)
}

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

print("File path is \(projectOption.value!)".red.bold)

if help.value {
    cli.printUsage()

    exit(EX_OK)
   
}

let project = projectOption.value ?? "."

let fileExtensions = "strings"

    Foo().bar()


