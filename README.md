# UTF-2

u vvvv wwww xxxx yyyy zzzz

### Code point → UTF-2 conversion

| extend bit | code point bit | utf2 char |
| ---------- | -------------- | --------- |
| e          | z              | e z {e z} |

| bits short of byte boundary | prepended bits | utf2 chars   |
| --------------------------- | -------------- | ------------ |
| 0                           | 11 00 00 00    | { utf2char } |
| 6                           | 10 00 00       | …            |
| 4                           | 01 00          | …            |
| 2                           | 00             | …            |

### Example

| Char | Dec | Bin     | UTF-2          |
| ---- | --- | ------- | -------------- |
| J    | 74  | 1001010 | 11101011101100 |

#### Explanation

```
┌─┬─ prepend bits
│ │    ┌────┬────┬────┬────┬────┬────┬─ code point bits
0 0  1 1  1 0  1 0  1 1  1 0  1 1  0 0
     └────┴────┴────┴────┴────┴────┴─ extend bits
```

## CLI

```
Usage: utf2 (--encode | --decode) < inputFile > outputFile
Options:
  --encode     converts utf8 data to utf2
  --decode     converts utf2 data to utf8
```

### Progress

    [x] encode
    [x] decode
    [x] testing

### local dev

#### pre-reqs

- ghc 9.12.1
- cabal 3.14.1.1

#### build

    ./compile.sh

#### Tests

    cabal v2-test

#### troubleshooting

    xxd -b dest/out.txt
