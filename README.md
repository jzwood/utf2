# UTF-2

u vvvv wwww xxxx yyyy zzzz

### Code point → UTF-2 conversion

| bits short of byte boundary | prepended bits | extend bit | code point bit | |
|---|-------------|---|---|--------|
| 0 | 11 00 00 00 | e | z | {e, z} |
| 6 | 10 00 00    |   |   |        |
| 4 | 01 00       |   |   |        |
| 2 | 00          |   |   |        |

### Example

| Char | Dec | Bin     | UTF-2          |
|------|-----|---------|----------------|
| J    | 74  | 1001010 | 11101011101100 |

#### Explanation

```
    1  0  0  1  0  1  0  --> code point
   11 10 10 11 10 11 00  --> extend bits
00 11 10 10 11 10 11 00  --> prepend bits
```
## CLI

```
Usage: utf2 (--encode | --decode) < inputFile > outputFile
Options:
  --encode     converts utf8 data to utf2
  --decode     converts utf2 data to utf8
```


### Progress

Currently under construction! 🚧


    [x] encode
    [x] decode
    [ ] testing


### local dev

#### pre-reqs

- ghc 9.12.1
- cabal 3.14.1.1

#### build

    ./compile.sh

#### troubleshooting

    xxd -b dest/out.txt
