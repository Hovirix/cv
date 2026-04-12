%-------------------------------------------------------------------------------
% resume-format.cls
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume-format}[2025/12/14 Resume/CV class]

%-------------------------------------------------------------------------------
% Class options
%-------------------------------------------------------------------------------
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

%-------------------------------------------------------------------------------
% Packages
%-------------------------------------------------------------------------------
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{ragged2e}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{ifxetex}
\RequirePackage{xifthen}
\RequirePackage{etoolbox}
\RequirePackage{setspace}
\RequirePackage{fontawesome}
\RequirePackage{parskip}
\RequirePackage{tcolorbox}
\RequirePackage{hyperref}

\ifxetex
  \RequirePackage[quiet]{fontspec}
  \RequirePackage{unicode-math}
  \defaultfontfeatures{Ligatures=TeX}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
\fi

\hypersetup{
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={},
  colorlinks=false,
  allbordercolors=white
}

%-------------------------------------------------------------------------------
% Font directory
%-------------------------------------------------------------------------------
\newcommand*{\fontdir}[1][fonts/]{\def\@fontdir{#1}}
\fontdir

%-------------------------------------------------------------------------------
% Sizes and spacing
%-------------------------------------------------------------------------------
\newcommand*{\@headernamefontsize}{32pt}
\newcommand*{\@headernamelineheight}{38pt}
\newcommand*{\@headerpositionfontsize}{8pt}
\newcommand*{\@headerpositionlineheight}{10pt}
\newcommand*{\@headeraddressfontsize}{9pt}
\newcommand*{\@headeraddresslineheight}{11pt}
\newcommand*{\@headersocialfontsize}{8pt}
\newcommand*{\@headersociallineheight}{10pt}
\newcommand*{\@headerquotefontsize}{10pt}

\newcommand*{\@sectionfontsize}{16pt}
\newcommand*{\@sectionlineheight}{18pt}
\newcommand*{\@subsectionfontsize}{12pt}
\newcommand*{\@subsectionlineheight}{14pt}

\newcommand*{\@entrytitlefontsize}{12pt}
\newcommand*{\@entrytitlelineheight}{14pt}
\newcommand*{\@entrypositionfontsize}{11pt}
\newcommand*{\@entrypositionlineheight}{13pt}
\newcommand*{\@entrydatefontsize}{9pt}
\newcommand*{\@entrydatelineheight}{11pt}
\newcommand*{\@entrylocationfontsize}{10pt}
\newcommand*{\@entrylocationlineheight}{12pt}
\newcommand*{\@descriptionfontsize}{11pt}
\newcommand*{\@descriptionlineheight}{13pt}

\newcommand*{\@skillfontsize}{10pt}
\newcommand*{\@skilltypefontsize}{9pt}
\newcommand*{\@skillsetfontsize}{9pt}
\newcommand*{\@achievementfontsize}{9pt}
\newcommand*{\@personalstatementfontsize}{10pt}
\newcommand*{\@footerfontsize}{9pt}

\newcommand*{\@honortitlefontsize}{10pt}
\newcommand*{\@honorpositionfontsize}{10pt}
\newcommand*{\@honordatefontsize}{10pt}
\newcommand*{\@honorlocationfontsize}{10pt}

\newcommand*{\@subentrytitlefontsize}{9pt}
\newcommand*{\@subentrypositionfontsize}{7pt}
\newcommand*{\@subentrydatefontsize}{7pt}
\newcommand*{\@subentrylocationfontsize}{7pt}
\newcommand*{\@subdescriptionfontsize}{9pt}

\newcommand*{\@sectionspacebefore}{1.5ex}
\newcommand*{\@sectionspaceafter}{1ex}
\newcommand*{\@entryspacing}{2mm}
\newcommand*{\@bulletindent}{2ex}
\newcommand*{\@bulletspacebefore}{-4mm}
\newcommand*{\@bulletspaceafter}{0mm}
\newcommand*{\@achievementspacing}{1.2mm}
\newcommand*{\@achievementspaceafter}{2mm}

\newcommand*{\@headerboxradius}{3pt}
\newcommand*{\@headerbiospacing}{1.5mm}

%-------------------------------------------------------------------------------
% Layout
%-------------------------------------------------------------------------------
\geometry{left=1.5cm, top=0.5cm, right=1.5cm, bottom=0.5cm, footskip=.5cm}

\fancyhfoffset{0em}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}
\pagestyle{fancy}

%-------------------------------------------------------------------------------
% Colors
%-------------------------------------------------------------------------------
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{5D5D5D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
\colorlet{lighttext}{lightgray}

% Theme palette
\definecolor{marineblue}{HTML}{123A6D}

\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{FB4485}
\definecolor{awesome-pink}{HTML}{F04C8A}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}

% Active theme colors
\colorlet{awesome}{marineblue}
\colorlet{headerbg}{marineblue}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{awesome}#1#2#3%
  }%
  \stepcounter{colorCounter}%
}

%-------------------------------------------------------------------------------
% Fonts
%-------------------------------------------------------------------------------
\ifxetex
  \def\@robotofullspec{%
    Path=\@fontdir,
    UprightFont=*-Regular,
    ItalicFont=*-Italic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic%
  }

  \newfontfamily\headerfont[\@robotofullspec]{Roboto}
  \newfontfamily\footerfont[\@robotofullspec]{Roboto}
  \newfontfamily\bodyfont[\@robotofullspec]{Roboto}

  \newfontfamily\headerfontlight[
    Path=\@fontdir,
    UprightFont=*-Thin,
    ItalicFont=*-ThinItalic,
    BoldFont=*-Medium,
    BoldItalicFont=*-MediumItalic
  ]{Roboto}

  \newfontfamily\bodyfontlight[
    Path=\@fontdir,
    UprightFont=*-Light,
    ItalicFont=*-LightItalic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic
  ]{Roboto}

  \setmainfont[\@robotofullspec]{Roboto}
\else
  \newcommand{\headerfont}{\rmfamily}
  \newcommand{\footerfont}{\rmfamily}
  \newcommand{\bodyfont}{\rmfamily}
  \newcommand{\headerfontlight}{\rmfamily}
  \newcommand{\bodyfontlight}{\rmfamily}
\fi

%-------------------------------------------------------------------------------
% Styles
%-------------------------------------------------------------------------------
\newcommand*{\headerfirstnamestyle}[1]{{\fontsize{\@headernamefontsize}{\@headernamelineheight}\headerfontlight\color{white}#1}}
\newcommand*{\headerlastnamestyle}[1]{{\fontsize{\@headernamefontsize}{\@headernamelineheight}\headerfont\color{white}#1}}
\newcommand*{\headerpositionstyle}[1]{{\fontsize{\@headerpositionfontsize}{\@headerpositionlineheight}\bodyfont\scshape\color{awesome}#1}}
\newcommand*{\headeraddressstyle}[1]{{\fontsize{\@headeraddressfontsize}{\@headeraddresslineheight}\headerfont\itshape\color{lighttext}#1}}
\newcommand*{\headersocialstyle}[1]{{\fontsize{\@headersocialfontsize}{\@headersociallineheight}\headerfont\color{text}#1}}
\newcommand*{\headerquotestyle}[1]{{\fontsize{\@headerquotefontsize}{1em}\bodyfont\itshape\color{darktext}#1}}
\newcommand*{\footerstyle}[1]{{\fontsize{\@footerfontsize}{1em}\footerfont\scshape\color{lighttext}#1}}

\newcommand*{\sectionstyle}[1]{{\fontsize{\@sectionfontsize}{\@sectionlineheight}\bodyfont\bfseries\color{text}\@sectioncolor #1}}
\newcommand*{\subsectionstyle}[1]{{\fontsize{\@subsectionfontsize}{\@subsectionlineheight}\bodyfont\scshape\textcolor{text}{#1}}}

\newcommand*{\entrytitlestyle}[1]{{\fontsize{\@entrytitlefontsize}{\@entrytitlelineheight}\bodyfont\bfseries\color{darktext}#1}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{\@entrypositionfontsize}{\@entrypositionlineheight}\bodyfont\scshape\color{graytext}#1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{\@entrydatefontsize}{\@entrydatelineheight}\bodyfontlight\slshape\color{graytext}#1}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{\@entrylocationfontsize}{\@entrylocationlineheight}\bodyfontlight\slshape\color{awesome}#1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{\@descriptionfontsize}{\@descriptionlineheight}\bodyfontlight\upshape\color{text}#1}}

\newcommand*{\subentrytitlestyle}[1]{{\fontsize{\@subentrytitlefontsize}{1em}\bodyfont\mdseries\color{graytext}#1}}
\newcommand*{\subentrypositionstyle}[1]{{\fontsize{\@subentrypositionfontsize}{1em}\bodyfont\scshape\color{graytext}#1}}
\newcommand*{\subentrydatestyle}[1]{{\fontsize{\@subentrydatefontsize}{1em}\bodyfontlight\slshape\color{graytext}#1}}
\newcommand*{\subentrylocationstyle}[1]{{\fontsize{\@subentrylocationfontsize}{1em}\bodyfontlight\slshape\color{awesome}#1}}
\newcommand*{\subdescriptionstyle}[1]{{\fontsize{\@subdescriptionfontsize}{1em}\bodyfontlight\upshape\color{text}#1}}

\newcommand*{\honortitlestyle}[1]{{\fontsize{\@honortitlefontsize}{1em}\bodyfont\color{graytext}#1}}
\newcommand*{\honorpositionstyle}[1]{{\fontsize{\@honorpositionfontsize}{1em}\bodyfont\bfseries\color{darktext}#1}}
\newcommand*{\honordatestyle}[1]{{\fontsize{\@honordatefontsize}{1em}\bodyfont\color{graytext}#1}}
\newcommand*{\honorlocationstyle}[1]{{\fontsize{\@honorlocationfontsize}{1em}\bodyfontlight\slshape\color{awesome}#1}}

\newcommand*{\skilltypestyle}[1]{{\fontsize{\@skilltypefontsize}{1em}\bodyfontlight\color{text}\textbf{#1}}}
\newcommand*{\skillsetstyle}[1]{{\fontsize{\@skillsetfontsize}{1em}\bodyfontlight\color{text}#1}}

\newcommand*{\achievementstyle}[1]{{\fontsize{\@achievementfontsize}{1em}\bodyfontlight\upshape\color{text}#1}}
\newcommand*{\cvparagraphstyle}[1]{{\fontsize{\@achievementfontsize}{1em}\bodyfontlight\upshape\color{text}#1}}
\newcommand*{\personalstatementstyle}[1]{{\fontsize{\@personalstatementfontsize}{1em}\bodyfontlight\upshape\color{text}#1}}

%-------------------------------------------------------------------------------
% Utilities
%-------------------------------------------------------------------------------
\newcommand{\roundedheaderbox}[2]{%
  \begin{tcolorbox}[
    colback=#1,
    colframe=#1,
    boxrule=0pt,
    arc=\@headerboxradius,
    left=10pt,
    right=10pt,
    top=10pt,
    bottom=10pt,
    width=\textwidth
  ]
    #2
  \end{tcolorbox}%
}

\newcommand{\displayurl}[1]{\href{#1}{\nolinkurl{#1}}}
\newcommand{\shortdisplayurl}[1]{\href{#1}{\urlstyle{same}\url{\detokenize{#1}}}}

\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill\kern\z@}
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}

%-------------------------------------------------------------------------------
% Personal info
%-------------------------------------------------------------------------------
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}

\newcommand*{\address}[1]{\def\@address{#1}}
\newcommand*{\position}[1]{\def\@position{#1}}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\link}[1]{\def\@link{#1}}
\newcommand*{\github}[1]{\def\@github{#1}}
\newcommand*{\location}[1]{\def\@location{#1}}
\newcommand*{\linkedin}[1]{\def\@linkedin{#1}}
\newcommand*{\stackoverflow}[2]{\def\@stackoverflowid{#1}\def\@stackoverflowname{#2}}
\newcommand*{\skype}[1]{\def\@skype{#1}}
\newcommand*{\twitter}[1]{\def\@twitter{#1}}
\renewcommand*{\quote}[1]{\def\@quote{#1}}

\newcommand*{\recipient}[2]{\def\@recipientname{#1}\def\@recipientaddress{#2}}
\newcommand*{\recipientname}[1]{\def\@recipientname{#1}}
\newcommand*{\recipientaddress}[1]{\def\@recipientaddress{#1}}
\newcommand*{\lettertitle}[1]{\def\@lettertitle{#1}}
\newcommand*{\letterdate}[1]{\def\@letterdate{#1}}
\newcommand*{\letteropening}[1]{\def\@letteropening{#1}}
\newcommand*{\letterclosing}[1]{\def\@letterclosing{#1}}

\newcommand*{\letterenclname}[1][Enclosure]{\def\@letterenclname{#1}}
\newcommand*{\letterenclosure}[2][]{%
  \ifthenelse{\equal{#1}{}}{}{\def\@letterenclname{#1}}%
  \def\@letterenclosure{#2}%
}

\newcommand*{\headersocialsep}[1][\quad\textbar\quad]{\def\@headersocialsep{#1}}
\headersocialsep

%-------------------------------------------------------------------------------
% Header / footer
%-------------------------------------------------------------------------------
\newcommand*{\makecvheader}{%
  \begin{center}
    \headerfirstnamestyle{\@firstname}\ \headerlastnamestyle{\@lastname}\\
    \vspace{0.4mm}

    \ifthenelse{\isundefined{\@position}}{}{\headerpositionstyle{\@position\\}}
    \vspace{0.4mm}

    \ifthenelse{\isundefined{\@address}}{}{\headeraddressstyle{\@address\\}}
    \vspace{-0.5mm}

    \headersocialstyle{%
      \newbool{isstart}%
      \setbool{isstart}{true}%

      \ifthenelse{\isundefined{\@mobile}}{}{%
        \faMobile\ \@mobile%
        \setbool{isstart}{false}%
      }%

      \ifthenelse{\isundefined{\@email}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \href{mailto:\@email}{\faEnvelope\ \@email}%
      }%

      \ifthenelse{\isundefined{\@link}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \href{http://\@link}{\faLink\ \@link}%
      }%

      \ifthenelse{\isundefined{\@github}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \href{https://github.com/\@github}{\faGithubSquare\ \@github}%
      }%

      \ifthenelse{\isundefined{\@stackoverflowid}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \href{https://stackoverflow.com/users/\@stackoverflowid}{\faStackOverflow\ \@stackoverflowname}%
      }%

      \ifthenelse{\isundefined{\@linkedin}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \href{https://www.linkedin.com/in/\@linkedin}{\faLinkedinSquare\ \@linkedin}%
      }%

      \ifthenelse{\isundefined{\@location}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \faMapMarker\ \@location%
      }%

      \ifthenelse{\isundefined{\@twitter}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \href{https://twitter.com/\@twitter}{\faTwitter\ \@twitter}%
      }%

      \ifthenelse{\isundefined{\@skype}}{}{%
        \ifbool{isstart}{\setbool{isstart}{false}}{\@headersocialsep}%
        \faSkype\ \@skype%
      }%
    }\\

    \ifthenelse{\isundefined{\@quote}}{}{%
      \vspace{6mm}\headerquotestyle{\@quote\\}\vspace{5mm}%
    }%
  \end{center}%
}

\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}%
  \fancyfoot[L]{\footerstyle{#1}}%
  \fancyfoot[C]{\footerstyle{#2}}%
  \fancyfoot[R]{\footerstyle{#3}}%
}

%-------------------------------------------------------------------------------
% Structural commands
%-------------------------------------------------------------------------------
\newcommand{\cvsection}[1]{%
  \par\addvspace{\@sectionspacebefore}%
  \phantomsection
  \sectionstyle{#1}%
  \color{gray}\vhrulefill{0.10pt}%
  \par\nobreak\addvspace{\@sectionspaceafter}%
}

\newcommand{\cvsubsection}[1]{%
  \phantomsection
  \subsectionstyle{#1}%
}

%-------------------------------------------------------------------------------
% Environments
%-------------------------------------------------------------------------------
\newenvironment{cvitems}{
  \vspace{\@bulletspacebefore}
  \begin{justify}
    \begin{itemize}[leftmargin=\@bulletindent, nosep, noitemsep]
      \setlength{\parskip}{0pt}
      \renewcommand{\labelitemi}{\bullet}
}{
    \end{itemize}
  \end{justify}
  \vspace{\@bulletspaceafter}
}

\newenvironment{cvparagraphs}{
  \vspace{-4mm}
  \begin{justify}
    \begin{itemize}[leftmargin=-2ex, nosep, noitemsep, before=\achievementstyle]
      \setlength{\parskip}{0pt}
      \renewcommand{\labelitemi}{\bullet}
}{
    \end{itemize}
  \end{justify}
  \vspace{-2mm}
}

\newenvironment{cventries}{}{}

\newcommand*{\cventry}[5]{%
  \ifempty{#2#3}
    {\entrytitlestyle{#1} \hfill \entrydatestyle{#4}\\\descriptionstyle{#5}}
    {\entrytitlestyle{#2} \hfill \entrylocationstyle{#3}\\
     \entrypositionstyle{#1} \hfill \entrydatestyle{#4}\\
     \descriptionstyle{#5}}%
  \vspace{\@entryspacing}%
}

\newenvironment{cvsubentries}{
  \begin{center}
}{
  \end{center}
}

\newcommand*{\cvsubentry}[4]{%
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{12.5cm} R{4.5cm}}
    \setlength\leftskip{0.2cm}
    \subentrytitlestyle{#2} &
    \ifthenelse{\equal{#1}{}}{\subentrydatestyle{#3}}{}%
    \ifthenelse{\equal{#1}{}}{}{\subentrypositionstyle{#1} & \subentrydatestyle{#3} \\}%
    \ifthenelse{\equal{#4}{}}{}{\multicolumn{2}{L{17.0cm}}{\subdescriptionstyle{#4}}\\}%
  \end{tabular*}
}

\newenvironment{cvhonors}{
  \begin{center}
    \setlength\tabcolsep{0pt}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} C{1.5cm} L{13.0cm} R{2.5cm}}
}{
    \end{tabular*}
  \end{center}
}

\newcommand*{\cvhonor}[4]{%
  \honordatestyle{#4} & \honorpositionstyle{#1}, \honortitlestyle{#2} & \honorlocationstyle{#3}\\
}

\newenvironment{cvachievements}{
  \vspace{-2mm}
  \bodyfontlight
  \begin{justify}
    \fontsize{\@achievementfontsize}{1em}\selectfont
    \begin{itemize}[leftmargin=0ex, label={}, nosep, noitemsep, before=\achievementstyle]
      \setlength{\parskip}{\@achievementspacing}
}{
    \end{itemize}
  \end{justify}
  \vspace{\@achievementspaceafter}
}

\newenvironment{cvpersonalstatement}{
  \vspace{4mm}
  \bodyfontlight
  \begin{justify}
    \fontsize{\@personalstatementfontsize}{14pt}\selectfont
    \begin{itemize}[leftmargin=0ex, label={}, nosep, noitemsep, before=\cvparagraphstyle]
      \setlength{\parskip}{3mm}
}{
    \end{itemize}
  \end{justify}
  \vspace{2mm}
}

\newenvironment{cvskills}{
  \begin{center}
    \setlength\tabcolsep{1ex}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} l L{20.2cm}}
}{
    \end{tabular*}
  \end{center}
}

\newcommand*{\cvskill}[2]{%
  \skilltypestyle{#1} & \skillsetstyle{#2}\\
}

\newenvironment{cvlinks}{
  \vspace{2mm}
  \bodyfontlight
  \color{lighttext}
  \begin{flushright}
}{
  \end{flushright}
  \vspace{2mm}
}

\newenvironment{cvfooterlink}{
  \vspace{2mm}
  \bodyfontlight
  \color{lighttext}
  \begin{flushright}
    \tiny
}{
  \end{flushright}
  \vspace{2mm}
}

\newenvironment{cvparagraph}{
  \vspace{-2mm}
  \begin{justify}
    \begin{itemize}[leftmargin=0ex, label={}, nosep, noitemsep, before=\descriptionstyle]
      \setlength{\parskip}{0pt}
}{
    \end{itemize}
  \end{justify}
  \vspace{-2mm}
}
