# Effortless Extraction Shell Function

This is a shell function called `extract` which is designed to extract a variety of file formats. It takes one or more arguments, each of which represents a file or path that needs to be extracted. If no arguments are provided, the function displays usage instructions.

This project, forked from [xvoland/Extract](https://github.com/xvoland/Extract), now features an enhanced installer and colorful output.

## Installation

Add the function to `.bashrc` or `.zshrc`. It is recommended to use the installer, which checks the programs on your machine and removes unsupported patterns.

```sh
git clone https://github.com/Chen1Plus/Extract.git && cd Extract
chmod +x ./installer.sh && ./installer.sh >> ~/.bashrc # or ~/.zshrc
```

You may have to restart your terminal or source the rc file to make `extract` available.

```sh
source ~/.bashrc # or ~/.zshrc
extract
```

## License

This project is forked from [xvoland/Extract](https://github.com/xvoland/Extract), which is licensed under the MIT License. This project is also licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
