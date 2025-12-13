% Identification        ==================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{femathesis}[2025/12/13 LaTeX document class for Undergraduate Thesis is the Faculty of Engineering Mechanics and Automation (FEMA), Vietnam National University Hanoi, University of Engineering and Technology (VNU-UET)]

% Preliminary declarations      ==================================================
\RequirePackage{amsmath,amssymb,siunitx}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{array}
\RequirePackage{indentfirst}
\RequirePackage{tikz}\usetikzlibrary{calc}

\raggedbottom
\lefthyphenmin 64
\frenchspacing
\pagenumbering{roman}
\newcounter{firstContentPageIndex}

\widowpenalty \@M
\clubpenalty \@M
\@beginparpenalty -51
\@endparpenalty -51
\@itempenalty -51

\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\theenumii)}
\newcommand\labelenumiii{\theenumiii)}
\newcommand\labelenumiv{\theenumiv)}
\renewcommand\p@enumii{\theenumi.}
\renewcommand\p@enumiii{\theenumi.\theenumii.}
\renewcommand\p@enumiv{\p@enumiii.\theenumiii.}

\newcommand\labelitemi{\labelitemfont \char"2013}
\newcommand\labelitemii{\labelitemfont +}
\newcommand\labelitemiii{\labelitemfont \char"2022}
\newcommand\labelitemiv{\labelitemfont \char"25E6}
\newcommand\labelitemfont{\normalfont}

% class option
\newif\ifthesis
\newif\ifsummary
% font size
\newlength\customfontsize
\newcommand{\skipfactor}{1.3} % default
\newcommand{\setfontsize}[1]{
    \setlength\customfontsize{#1}
    \fontsize{\customfontsize}{\skipfactor\customfontsize}\selectfont
}


\def\@meta@studentname{\PackageError{femathesis}{Student name is not specified.}{
	The student's name needs to be specified for the cover pages.
}}
\def\@meta@title{\PackageError{femathesis}{Title is not specified.}{
	The title needs to be specified for the cover pages.
}}
\def\@meta@major{\PackageError{femathesis}{Major is not specified.}{
	The major needs to be specified for the cover pages.
}}
\def\@meta@year{\PackageError{femathesis}{Year is not specified.}{
	The year needs to be specified for the cover pages.
}}
\def\@meta@supervisor{\PackageError{femathesis}{Supervisor name is not specified.}{
	The supervisor's name needs to be specified for the cover pages.
}}
\def\@meta@cosupervisor\relax
\def\@meta@englishtitle\relax
\def\@meta@englishmajor{\PackageError{femathesis}{English major is not specified.}{
	The major name in English needs to be specified for the cover pages.
}}
\def\@meta@englishsupervisor{\PackageError{femathesis}{English supervisor name is not specified.}{
	The supervisor's name in English needs to be specified for the cover pages.
}}
\def\@meta@englishcosupervisor{\PackageError{femathesis}{English co-supervisor name is not specified.}{
	The co-supervisor's name in Engligh needs to be specified for the cover pages.
}}

\newif\if@meta@hascosupervisor\@meta@hascosupervisorfalse
\newif\if@meta@hasenglishsections\@meta@hasenglishsectionsfalse
\DeclareRobustCommand\studentname[1]{\global\def\@meta@studentname{#1}}
\DeclareRobustCommand\title[1]{\global\def\@meta@title{#1}}
\DeclareRobustCommand\major[1]{\global\def\@meta@major{#1}}
\DeclareRobustCommand\year[1]{\global\def\@meta@year{#1}}
\DeclareRobustCommand\supervisor[1]{\global\def\@meta@supervisor{#1}}
\DeclareRobustCommand\cosupervisor[1]{\global\def\@meta@cosupervisor{#1}\@meta@hascosupervisortrue}
\DeclareRobustCommand\englishtitle[1]{\global\def\@meta@englishtitle{#1}\@meta@hasenglishsectionstrue}
\DeclareRobustCommand\englishmajor[1]{\global\def\@meta@englishmajor{#1}}
\DeclareRobustCommand\englishsupervisor[1]{\global\def\@meta@englishsupervisor{#1}}
\DeclareRobustCommand\englishcosupervisor[1]{\global\def\@meta@englishcosupervisor{#1}}

% Options   ==================================================
\DeclareOption{thesis}{\thesistrue}
\DeclareOption{summary}{\summarytrue}
\ProcessOptions\relax

% Body      ==================================================
% a. Handle class option
\ifsummary\ifthesis
  \ClassError{femathesis}{Options 'thesis' and 'summary' cannot be used together}{Choose only one of: thesis, summary.}
\fi\fi

\ifthesis\else\ifsummary\else
    \thesistrue
\fi\fi

% b. Load packages according to class option
\ifthesis
    \input{femathesis.clo}
    \RequirePackage[a4paper,left=3cm,right=2cm,top=2.5cm,bottom=3cm,includefoot,footskip=1cm]{geometry}
    \renewcommand{\skipfactor}{1.3}
\fi

\ifsummary
    \input{femasummary.clo}
    \RequirePackage[a5paper,left=2cm,right=2cm,top=2cm,bottom=2cm,includefoot,footskip=1cm]{geometry}
    \renewcommand{\skipfactor}{1.54}
\fi

% c. Math + math font

% -------------------
% Original approach -
% -------------------
% \RequirePackage{fontspec}
% \RequirePackage[fontspec-loader]{mathfont}
% \directlua{
%     function custom_math_constants(fontdata)
%     fontdata.MathConstants = fontdata.MathConstants or {}
%     fontdata.MathConstants["SpaceAfterScript"] = 0
%     mathfont.math_constants(fontdata)
% end
% luatexbase.add_to_callback("mathfont.add_math_constants", custom_math_constants, "custom_math_constants")
% }
% \mathfont[upper,lower,digits]{Times New Roman}

% --------------
% New approach -
% --------------
\RequirePackage{fontspec}
\RequirePackage{unicode-math}

% d. main text font + mathfont for digits/letters
\setmainfont{Times New Roman}
\setmathfont{Latin Modern Math}

% e. environments

% -------------
% cover pages -
% -------------
\ifthesis
	\newenvironment{coverpage}{%
		\setlength\parindent{0cm}\tikz[overlay, remember picture]{
			\draw[line width=3pt,color=black,fill=none]
				($(current page.north west)+(2.5cm,-2cm)$) rectangle ($(current page.south east)-(1.5cm,-3.5cm)$);
			\draw[line width=1pt,color=black,fill=none]
				($(current page.north west)+(2.65cm,-2.15cm)$) rectangle ($(current page.south east)-(1.65cm,-3.65cm)$);
		}%
	}{\clearpage\normalsize}

	\newcommand\makecovers{
		\begin{coverpage}%
			\centering%
			\setfontsize{12pt}\textbf{ĐẠI HỌC QUỐC GIA HÀ NỘI}\\
			\textbf{TRƯỜNG ĐẠI HỌC CÔNG NGHỆ}\par
			\vspace{1.2cm}\includegraphics[scale=0.55]{UET logo.pdf}\par
			\vspace{0.25cm}\setfontsize{14pt}\textbf{\@meta@studentname}\par
			\vspace{1.75cm}\setfontsize{18pt}\textbf{\MakeUppercase{\@meta@title}}\par
			\vspace{3.5cm}\setfontsize{14pt}\textbf{\MakeUppercase{Đồ án tốt nghiệp đại học hệ chính quy}}\par
			\textbf{Ngành: \@meta@major}\par
			\vfill\setfontsize{12pt}\textbf{HÀ NỘI -- \@meta@year}\par%
		\end{coverpage}
		\begin{coverpage}%
			{
				\centering%
				\setfontsize{12pt}\textbf{ĐẠI HỌC QUỐC GIA HÀ NỘI}\\
				\textbf{TRƯỜNG ĐẠI HỌC CÔNG NGHỆ}\par
				\vspace{2cm}\setfontsize{14pt}\textbf{\@meta@studentname}\par
				\vspace{2cm}\setfontsize{18pt}\textbf{\MakeUppercase{\@meta@title}}\par
				\vspace{3cm}\setfontsize{14pt}\textbf{\MakeUppercase{Đồ án tốt nghiệp đại học hệ chính quy}}\par
				\textbf{Ngành: \@meta@major}\par%
			}
			\vspace{2.5cm}\setfontsize{14pt}\textbf{Cán bộ hướng dẫn: \@meta@supervisor}\par%
			\if@meta@hascosupervisor\vspace{3cm}\textbf{Cán bộ đồng hướng dẫn: \@meta@cosupervisor}\par\fi%
			{
				\centering\vfill\setfontsize{12pt}\textbf{HÀ NỘI -- \@meta@year}\par%
			}
		\end{coverpage}
		\if@meta@hasenglishsections\begin{coverpage}%
			{
				\centering%
				\setfontsize{12pt}\textbf{VIETNAM NATIONAL UNIVERSITY, HANOI}\\
				\textbf{UNIVERSITY OF ENGINEERING AND TECHNOLOGY}\par
				\vspace{2cm}\setfontsize{14pt}\textbf{\@meta@studentname}\par
				\vspace{2cm}\setfontsize{18pt}\textbf{\MakeUppercase{\@meta@englishtitle}}\par
				\vspace{3cm}\setfontsize{14pt}\textbf{Major: \@meta@englishmajor}\par
			}
			\vspace{3cm}\setfontsize{14pt}\textbf{Supervisor: \@meta@englishsupervisor}\par%
			\if@meta@hascosupervisor\vspace{3cm}\textbf{Co-Supervisor: \@meta@englishcosupervisor}\par\fi%
			{
				\centering\vfill\setfontsize{12pt}\textbf{HÀ NỘI -- \@meta@year}\par%
			}
		\end{coverpage}\fi
	}
	\fi
	
\ifsummary
	\newenvironment{coverpage}{%
		\setlength\parindent{0cm}\tikz[overlay, remember picture]{
			\draw[line width=3pt,color=black,fill=none]
			($(current page.north west)+(2cm,-1.5cm)$) rectangle ($(current page.south east)-(2cm,-2.5cm)$);
		}%
	}{\clearpage\normalsize}

	\newcommand\makecovers{
		\begin{coverpage}%
			{
				\centering%
				\setfontsize{9pt}\textbf{ĐẠI HỌC QUỐC GIA HÀ NỘI}\\
				\textbf{TRƯỜNG ĐẠI HỌC CÔNG NGHỆ}\\[-6pt]
				\rule{2.5cm}{1pt}\par
				\vspace{1.5cm}\setfontsize{11pt}\textbf{\@meta@studentname}\par
				\vspace{1.5cm}\setfontsize{12pt}\textbf{\MakeUppercase{\@meta@title}}\par
				\vspace{1.5cm}\setfontsize{11pt}\textbf{Ngành: \@meta@major}\par%
				\vspace{2cm}\setfontsize{11pt}\textbf{\MakeUppercase{Tóm tắt đồ án tốt nghiệp}}\par
				\vfill\setfontsize{9pt}\textbf{HÀ NỘI -- \@meta@year}\par%
			}
		\end{coverpage}
	}
\fi

% ----------
% abstract -
% ----------
\ifthesis
	\newenvironment{preamble}[1]{%
		\clearpage\setlength\parindent{0cm}
		{\centering\textbf{\MakeUppercase{#1}}\par}\vspace{1cm}
		\setfontsize{12pt}
	}{\normalsize}
\fi

% -----
% TOC -
% -----
\newif\if@incontentlisting\@incontentlistingfalse
\ifthesis
	\newenvironment{contentlisting}{\clearpage\@incontentlistingtrue}{\@incontentlistingfalse\clearpage}

	\setcounter{tocdepth}{3}

	\newenvironment{contentlistingsection}[1]{%
		\if@incontentlisting\else\PackageError{femathesis}{
			Content listing section not in \`contentlisting\` environment.
		}{
			To ensure consistency, place all content listing sections into the \`contentlisting\` environment.
		}\fi%
		\noindent\Large\textbf{#1}\par\vspace{1cm}\normalsize
	}{\clearpage}

	\newcommand\tableofcontents{\begin{contentlistingsection}{Mục lục}\@starttoc{toc}\end{contentlistingsection}}

	\renewcommand\numberline[2]{#1 #2}
	\newcommand\@tocline[4]{\ifnum #1>\c@tocdepth\else
		\vskip\z@\@plus.2\p@{%
			\raggedright\parindent #2\hangindent #2\rightskip 1cm\parfillskip -1cm\interlinepenalty\@M\leavevmode
			\ifnum #1=1\textbf{#3}\else #3\fi%
			\leaders\hbox{$\m@th\mkern0.5mu\hbox{.}\mkern0.5mu$}\hfill #4\par%
		}
	\fi}
	\newcommand*\l@chapter{\@tocline{1}{0cm}}
	\newcommand*\l@section{\@tocline{2}{0.5cm}}
	\newcommand*\l@subsection{\@tocline{3}{1cm}}
\fi

% ----------------------------------------------
% Chapter, section, subsection, appendix, ...  -
% ----------------------------------------------
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]

\renewcommand\thechapter{\@arabic\c@chapter}
\renewcommand\thesection{\thechapter.\@arabic\c@section}
\renewcommand\thesubsection{\thesection.\@arabic\c@subsection}
\newcommand\@chapterprefix{Chương}
\newif\if@firstchapter\@firstchaptertrue

\ifthesis
	\newcommand\chapter[1]{%
		\clearpage\refstepcounter{chapter}
		\if@firstchapter%
			\setcounter{firstContentPageIndex}{\value{page}}%
			\pagestyle{plain}\pagenumbering{arabic}\setcounter{page}{1}%
			\@firstchapterfalse%
		\fi
		\addcontentsline{toc}{chapter}{\protect\numberline{\@chapterprefix\ \thechapter.}{#1}}
		\noindent\huge\textbf{\@chapterprefix\ \thechapter.}\par
		\noindent\huge\textbf{#1}\par\vspace{1cm}\normalsize%
	}

	\newcommand\chapterstar[1]{%
		\clearpage
		\if@firstchapter
			\setcounter{firstContentPageIndex}{\value{page}}%
			\pagestyle{plain}\pagenumbering{arabic}\setcounter{page}{1}%
			\@firstchapterfalse
		\fi
		\addcontentsline{toc}{chapter}{#1}%
		\noindent\huge\textbf{#1}\par\vspace{1cm}\normalsize%
	}
\fi
	
\ifsummary
	\newcommand\chapter[1]{%
		\refstepcounter{chapter}
		\if@firstchapter%
			\setcounter{firstContentPageIndex}{\value{page}}%
			\pagestyle{plain}\pagenumbering{arabic}\setcounter{page}{1}%
			\@firstchapterfalse%
		\fi
		\par\smallskip
		\noindent\Large\textbf{\@chapterprefix\ \thechapter. #1}\par\normalsize%
	}

	\newcommand\chapterstar[1]{%
		\if@firstchapter
			\setcounter{firstContentPageIndex}{\value{page}}%
			\pagestyle{plain}\pagenumbering{arabic}\setcounter{page}{1}%
			\@firstchapterfalse
		\fi
		\addcontentsline{toc}{chapter}{#1}%
		\noindent\Large\textbf{#1}\par\normalsize%
	}
\fi

\ifthesis
	\newcommand\appendix{%
		\par%
		\setcounter{chapter}{0}%
		\setcounter{section}{0}%
		\renewcommand\@chapterprefix{Phụ lục}%
		\renewcommand\thechapter{\@Alph\c@chapter}%
	}
\fi

\newcommand\@makesection[2]{%
	\if@nobreak
        \everypar{}
    \else
        \addpenalty\@secpenalty
        \vspace{#1}
    \fi
    #2\par
    \nobreak
    \@nobreaktrue
    \normalsize%
    \everypar{\@nobreakfalse\everypar{}}
}

\ifthesis
	\newcommand\section[1]{\@makesection{1cm}{%
		\refstepcounter{section}
		\addcontentsline{toc}{section}{\protect\numberline{\thesection.}{#1}}
		\noindent\Large\textbf{\thesection. #1}
	}}
	\newcommand\subsection[1]{\@makesection{0.5cm}{%
		\refstepcounter{subsection}
		\addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection.}{#1}}
		\noindent\large\textbf{\thesubsection. #1}
	}}
	\newcommand\sectionstar[1]{%
		\@makesection{0cm}{%
			\noindent\Large\textbf{#1}%
		}%
	}
\fi

\ifsummary
	\newcommand\section[1]{\@makesection{0cm}{%
		\refstepcounter{section}%
		\noindent\large\textbf{\thesection. #1}%
	}}
	\newcommand\subsection[1]{\@makesection{0cm}{%
		\refstepcounter{subsection}%
		\noindent\large\textbf{\thesubsection. #1}%
	}}
	\newcommand\sectionstar[1]{%
		\@makesection{0cm}{%
			\noindent\large\textbf{#1}%
		}%
	}
\fi

% -------
% Media -
% -------
\newcommand\attachmentcaptionbox[1]{%
  \par
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    #1
  \par
  \endgroup
}

\newcommand\attachmentcaption{%
  \ifx\@captype\@undefined
    \PackageError{uetgraduation}{Caption outside attachment}{A caption needs to be inside an attachment environment.}%
  \fi
  \addcontentsline{\csname ext@\@captype\endcsname}{\@captype}{%
    \protect\numberline{\csname the\@captype\endcsname.}{\ignorespaces \@captiontext}%
  }%
  \csname prefix@\@captype\endcsname\nobreakspace\csname the\@captype\endcsname. \@captiontext%
}

\newcommand\makeattachmenttype[8]{
	\newcounter{a@#1}[chapter]
	\expandafter\renewcommand\csname thea@#1\endcsname{\thechapter.\@arabic\csname c@a@#1\endcsname}
	\expandafter\newcommand\csname fps@a@#1\endcsname{#2}
	\expandafter\newcommand\csname ftype@a@#1\endcsname{1}
	\expandafter\newcommand\csname ext@a@#1\endcsname{#6}
	\expandafter\newcommand\csname prefix@a@#1\endcsname{#3}

	\newcommand #7{\begin{contentlistingsection}{#8}\@starttoc{#6}\end{contentlistingsection}}
	
	\expandafter\newcommand\expandafter*\csname l@a@#1\endcsname{\@tocline{2}{0cm}}
	\expandafter\let\csname enda@#1\endcsname\end@float
	
	\newenvironment{#1}[2][]{%
		\refstepcounter{a@#1}\def\@captiontext{##2}\ifx&##1&\@float{a@#1}\else\@float{a@#1}[##1]\fi#4%
	}{#5\csname enda@#1\endcsname}
}

\makeattachmenttype{figure}{tbp}{Hình}{}{%
	\vspace{0.25cm}\attachmentcaptionbox{\centering\small\attachmentcaption}% 
}{lof}{\listoffigures}{Danh sách hình vẽ}

\makeattachmenttype{table}{tbp}{Bảng}{%
	\attachmentcaptionbox{\centering\small\textbf{\attachmentcaption}}\vspace{0.25cm}%
}{}{lot}{\listoftables}{Danh sách bảng}

\renewcommand\footnoterule{\kern-3\p@\hrule\@width.4\columnwidth\kern2.6\p@}
\newcommand\@makefntext[1]{\parindent 1em\noindent\hb@xt@1.8em{\hss\@makefnmark}#1}

% --------------
% Bibliography -
% --------------
\newcommand\bibname{Tài liệu tham khảo}

\newcounter{bibitem}
\renewcommand\thebibitem{\arabic{bibitem}}
\newif\if@inthebibliography\@inthebibliographyfalse
\newif\if@inbibsection\@inbibsectionfalse

\ifthesis
	\newenvironment{thebibliography}[1]{%
		\@inthebibliographytrue
		\settowidth\labelwidth{\@biblabel{#1}}%
		\clearpage
		\noindent\Large\textbf{\bibname}\par\normalsize\vspace{1cm}%
	}{%
		\@inthebibliographyfalse
	}
\fi

\ifsummary
	\newenvironment{thebibliography}[1]{%
		\@inthebibliographytrue
		\settowidth\labelwidth{\@biblabel{#1}}%
		\noindent\Large\textbf{\bibname}\par\normalsize%
	}{%
		\@inthebibliographyfalse
	}
\fi

\newenvironment{bibsection}[1]{%
    \if@inthebibliography\else
        \PackageError{uetgraduation}{\string\bibsection\space not in \string\thebibliography.}{%
            Place all bibsections inside the \string\thebibliography\space environment.%
        }%
    \fi
    \@inbibsectiontrue
    \noindent\textbf{#1}%
    \list{\@biblabel{\thebibitem}}{%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@nmbrlisttrue
        \def\@listctr{bibitem}%
    }%
    \sloppy
    \clubpenalty=4000
    \@clubpenalty\clubpenalty
    \widowpenalty=4000
    \sfcode`\.\@m
}{%
    \def\@noitemerr{}%
    \endlist
    \@inbibsectionfalse
}

\renewcommand\bibitem[1]{%
    \if@inbibsection\else
        \PackageError{uetgraduation}{\string\bibitem\space not in \string\bibsection.}{%
            Place all \string\bibitem\space inside a \string\bibsection\space environment.%
        }%
    \fi
    \item
    \if@filesw
        \immediate\write\@auxout{\string\bibcite{#1}{\the\value{\@listctr}}}%
    \fi
    \ignorespaces
}

\mathchardef\dcol="203A % Division colon (:).
\mathchardef\mdot="202E % Multiplication dot (.).
\mathchardef\ngt="2D % Negative sign (-).

% No page numbering for the cover and preamble pages, page numbering will automatically start at the first chapter.
\pagestyle{empty}
\bibliographystyle{plain}

% Prevent overflow of the text column at all costs.
\sloppy

\AtEndDocument{\@ifpackageloaded{hyperref}{}{\pdfextension catalog{/PageLabels<</Nums[%
	0<</S/r>>%
	\the\numexpr\value{firstContentPageIndex}-1\relax<</S/D>>%
]>>/PageLayout/OneColumn>>}}}