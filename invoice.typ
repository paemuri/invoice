#set page(paper: "a4", margin: (x: 2cm, y: 1.5cm), numbering: none)
#set text(font: "Liberation Sans", size: 12pt)
#set par(justify: false, leading: 0.45em)
#set document(title: "Commercial invoice", author: "Rafael Zichia")

#let refmonth = sys.inputs.at("refmonth")
#let shared = toml("data/main.toml")
#let month = toml("data/" + refmonth + ".toml")
#let data = (: ..shared, ..month)
#let invoice = data.invoice

#let weekdays = (
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
)

#let parse-date(value) = {
  if type(value) == datetime {
    value
  } else {
    let parts = value.split("-")
    datetime(
      year: int(parts.at(0)),
      month: int(parts.at(1)),
      day: int(parts.at(2)),
    )
  }
}

#let parse-time(value) = {
  if type(value) == datetime {
    value.hour() * 60 + value.minute()
  } else {
    let parts = value.split(":")
    int(parts.at(0)) * 60 + int(parts.at(1))
  }
}

#let format-hours(minutes) = {
  let hours = calc.floor(minutes / 60)
  let mins = calc.rem(minutes, 60)
  str(hours) + ":" + (if mins < 10 { "0" } else { "" }) + str(mins)
}

#let section(title, body) = block(below: 26pt)[
  #text(weight: "bold", size: 14.4pt)[#title] \
  #body
]

#text(weight: "bold", size: 17.28pt)[Commercial invoice \##invoice.reference]
#v(15pt)

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

#v(20pt)
#box(width: 100%, stroke: 0.5mm, inset: 0pt)[
  #table(
    columns: (1fr, 1fr),
    align: center + horizon,
    stroke: none,
    inset: (x: 5pt, y: 5pt),
    table.header([*Description of services*], [*Price*]),
    table.hline(stroke: 0.5mm),
    [#data.services.description], [#data.services.value],
  )
]

#if "timesheet" in data [
  #let days = data.timesheet.days
  #let day-minutes(day) = {
    let start = parse-time(day.time_in)
    let end = parse-time(day.time_out)
    if end < start { end + 24 * 60 - start } else { end - start }
  }
  #let total-minutes = days.fold(0, (total, day) => total + day-minutes(day))
  #let rows = days.map(day => {
    let date = parse-date(day.date)
    (
      date.display("[year]-[month padding:zero]-[day padding:zero]"),
      weekdays.at(date.weekday()),
      day.time_in,
      day.time_out,
      format-hours(day-minutes(day)),
    )
  }).flatten()

  #pagebreak()

  #section("Timesheet")[
    #box(width: 100%, stroke: 0.5mm, inset: 0pt)[
      #table(
        columns: (1fr, 1fr, 1fr, 1fr, 1fr),
        align: center + horizon,
        stroke: none,
        inset: (x: 5pt, y: 5pt),
        table.header(
          [*Date*],
          [*Weekday*],
          [*Time in*],
          [*Time out*],
          [*Total*],
        ),
        table.hline(stroke: 0.5mm),
        ..rows,
        table.hline(stroke: 0.5mm),
        table.cell(colspan: 4, align: right)[*#days.len() days worked*],
        [*#format-hours(total-minutes)*],
      )
    ]
  ]
]
