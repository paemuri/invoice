# Invoice

[![License][badge-1-img]][badge-1-link]

My personal invoice template built with LaTeX and Lua.

## Dependencies

- `lualatex`
- `pcre2grep` (optional)

## Invoice data

To generate a document, first it's needed to set the data for an
invoice, defined in the `data/` directory.

### Shared data

Create file `data/main.lua` with the following body:

```lua
exporter = {
  name = '...',
  id_number = '...',
  address = {
    '...',
    '...',
  },
}
consignee = {
  name = '...',
  id_number = '...',
  address = {
    '...',
    '...',
  },
}
bank_account = {
  payment_desc = '...',
  iban = '...',
  bank = {
    name = '...',
    swift_code = '...',
  },
}
```

### Month-specific data

Create file `data/YYYY-MM.lua` with the following body:

```lua
invoice = {
  reference = '...',
  issue_date = '...',
  reference_date = '...',
}
services = {
  description = '...',
  value = '...',
  currency = '...',
}
```

## Build

After the data is set, just run `./build YYYY-MM` with the correct
reference month and the PDF file will be generated in the `out/`
directory as `YYYY-MM-invoice-NNN.pdf`.

## License

This project code is in the public domain. See the [LICENSE file][1].

### Contribution

Unless you explicitly state otherwise, any contribution intentionally
submitted for inclusion in the work by you shall be in the public
domain, without any additional terms or conditions.

[1]: ./LICENSE

[badge-1-img]: https://img.shields.io/badge/license-Unlicense-green?style=flat-square
[badge-1-link]: ./LICENSE
