# Invoice

[![License][badge-1-img]][badge-1-link]

My personal invoice template built with Typst.

## Dependencies

- `typst` 0.13 or newer

## Invoice data

To generate a document, first set the data for an invoice in the `data/`
directory as TOML files.

### Shared data

Create `data/main.toml` with the following body:

```toml
[exporter]
name = "..."
id_number = "..."
address = ["...", "..."]

[consignee]
name = "..."
id_number = "..."
address = ["...", "..."]

[bank_account]
payment_desc = "..."
iban = "..."

[bank_account.bank]
name = "..."
swift_code = "..."

[bank_account.intermediary_bank]
name = "..."
swift_code = "..."
account_holder = "..."
account_number = "..."
```

### Month-specific data

Create `data/YYYY-MM.toml` with the following body:

```toml
[invoice]
reference = "..."
issue_date = "..."

[invoice.work_period]
dates = "..."
hours = "..."

[services]
description = "..."
value = "..."
```

## Build

Run `./build YYYY-MM` to build one invoice, or `./build` to build every TOML
file. The PDF is written to `out/` as `YYYY-MM-invoice-NNN.pdf`.

## License

This project code is in the public domain. See the [LICENSE file][1].

### Contribution

Unless you explicitly state otherwise, any contribution intentionally
submitted for inclusion in the work by you shall be in the public
domain, without any additional terms or conditions.

[1]: ./LICENSE

[badge-1-img]: https://img.shields.io/badge/license-Unlicense-green?style=flat-square
[badge-1-link]: ./LICENSE
