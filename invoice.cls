\ProvidesClass{invoice}
\NeedsTeXFormat{LaTeX2e}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions
\relax
\LoadClass{article}

% Imports.
\usepackage[a4paper, hmargin=2cm, vmargin=1.5cm]{geometry}
\usepackage{fontspec}
\usepackage{tabularx}

% Remove page numbering.
\pagenumbering{gobble}

% Remove indentation.
\setlength
\parindent{0pt}

% Set table size and format.
\setlength{\arrayrulewidth}{0.5mm}
%\setlength{\tabcolsep}{32pt}
\renewcommand{\arraystretch}{1.5}

% Sets fonts.
\defaultfontfeatures{Ligatures=TeX}
\setmainfont[
  Extension=.ttf,
  UprightFont=OpenSans-Regular,
  BoldFont=OpenSans-Bold,
  ItalicFont=OpenSans-Italic,
  BoldItalicFont=OpenSans-BoldItalic,
]{OpenSans-Regular}

%
% Environments and commands.
%

\newenvironment{invoicesectiontext}{}{\vspace{20pt}}

\newcommand{\invoicetitle}[1]{
  \bfseries
  \LARGE
  #1
  \vspace{15pt}
  \invoicestypereset
  \\
}

\newcommand{\invoicesectionheader}[1]{
  \bfseries
  \large
  #1
  \invoicestypereset
  \\
}

\newcommand{\invoicestypereset}[0]{
  \normalfont
  \normalsize
}

