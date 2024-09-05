# FOSS Star Wars: Unlimited Play Tokens

This repository contains the design files and build processes for an open source 3D printed SWU token set.
The tokens are dual-sided, and require a relatively fine printer to print; I've only used the Bambu A1, but please let me know
if you've tried any other printers!

If you're looking to print the tokens, check out the "Releases" tab.  Instructions are included in the relese package.

If you're planning on printing the tokens yourself, be sure to check out the LICENSE file -- basically you're free to use these however you'd like, provided:

* You provide credit to the original projecl
* If you make improvements to the project, you need to share the source code.


## Project Structure

This project uses OpenScad to design the tokens.  

The design files are located in the `src` directory.  Generally, the tokens have a common "base", and a token-specific "silkscren" design.  The silkscreen is embedded within the base, allowing for a flat token with the double-sided print design.

The `target` directory contains the files that are ultimately compiled into the STL files.  The tokens have a `base` and `silk` component; both of which are needed to print the token.

See the [printing documentation](docs/PRINTING.md) for guidelines describing how I've printed the tokens.
