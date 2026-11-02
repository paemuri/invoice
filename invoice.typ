#set page(paper: "a4", margin: (x: 2cm, y: 1.5cm), numbering: none)
#set text(font: "Liberation Sans", size: 12pt)
#set document(title: "Commercial invoice", author: "Rafael Zichia")

#let refmonth = sys.inputs.at("refmonth")
#let shared = toml("data/main.toml")
#let month = toml("data/" + refmonth + ".toml")
#let data = (: ..shared, ..month)
#let invoice = data.invoice

#let section(title, body) = block[
  #text(weight: "bold", size: 14.4pt)[#title] \
  #body
]

#text(weight: "bold", size: 17.28pt)[Commercial invoice \##invoice.reference]

#section("Issue date")[#invoice.issue_date]

#if "work_period" in invoice [
  #section("Work period")[
    #invoice.work_period.dates \
    #invoice.work_period.hours
  ]
]

#section("Exporter")[
  #data.exporter.name \
  #data.exporter.id_number \
  #data.exporter.address.join(linebreak())
]

#section("Consignee")[
  #data.consignee.name \
  #data.consignee.id_number \
  #data.consignee.address.join(linebreak())
]

#section("Payment")[
  #data.bank_account.payment_desc \
  IBAN: #data.bank_account.iban \
  Bank: #data.bank_account.bank.name \
  SWIFT code: #data.bank_account.bank.swift_code \
  Intermediary bank: #data.bank_account.intermediary_bank.name \
  SWIFT code: #data.bank_account.intermediary_bank.swift_code \
  Account holder: #data.bank_account.intermediary_bank.account_holder \
  Account number: #data.bank_account.intermediary_bank.account_number
]

#box(width: 100%, stroke: 0.5mm, inset: 0pt)[
  #table(
    columns: (1fr, 1fr),
    align: center + horizon,
    stroke: none,
    table.header([*Description of services*], [*Price*]),
    table.hline(stroke: 0.5mm),
    [#data.services.description], [#data.services.value],
  )
]
