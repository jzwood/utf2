# UTF-2

u vvvv wwww xxxx yyyy zzzz

### Code point ↔ UTF-2 conversion

| extend | code point |
|--------|------------|
| 1 bit  | 1 bit      |


### Example

| Char | Dec | Bin     | UTF-2          |
|------|-----|---------|----------------|
| J    | 74  | 1001010 | 11101011101100 |

#### Explanation

```
 1  0  0  1  0  1  0  --> binary codepoint
1  1  1  1  1  1  0   --> extension bits
11 10 10 11 10 11 00  --> utf2
11101011 10110000     --> utf2 bytestring
```
