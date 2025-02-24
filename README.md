# UTF-2

u vvvv wwww xxxx yyyy zzzz

### Code point → UTF-2 conversion

| extend | code point |
|--------|------------|
| 1 bit  | 1 bit      |

### Example

| Char | Dec | Bin     | UTF-2          |
|------|-----|---------|----------------|
| J    | 74  | 1001010 | 11101011101100 |

#### Explanation

| |1| |0| |0| |1| |0| |1| |0| binary code point |
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-------------------|
|1| |1| |1| |1| |1| |1| |0| | extend bit        |
|1|1|1|0|1|0|1|1|1|0|1|1|0|0| utf2              |

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
    [ ] decode



### local dev

#### pre-reqs

- ghc 9.12.1
- cabal 3.14.1.1

#### build

    ./compile.sh

#### troubleshooting

    xxd -b dest/out.txt
