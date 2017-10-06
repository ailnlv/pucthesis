%% $Id: pucthesis.cls 112 2009-12-28 15:18:57Z raul $
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pucthesis}[2007/05/07 v1.1 PUC Thesis class]
\wlog{+-------------------------------------------------------------+}
\wlog{| Miguel Torres-Torriti <Apr 2007>: Modified from UdeM thesis |}
\wlog{+-------------------------------------------------------------+}

\setcounter{errorcontextlines}{5} %% For debugging

%------------------------------------------------------------------------------
% Beginning of pucthesis.cls  25-June-2008  v. 1.2
%                             07-May-2007   v. 1.1
%                             04-April-2007 v. 1.0
%
%
% Modified version of the original:
%            udemphd-l.sty    23-April-1993; 
%                             modification 17-aug-93
%------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This file is designed to work with AMSLaTeX version 1.2. It uses
% amsbook.cls as a base and modifies page size, top matter, section
% headings, etc. to produce a PUC style for Ph.D./M.Eng. thesis  
%
% Instructions:
%
%   -- In a document file, use \documentclass{pucthesis}.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% pucthesis is based on the amsbook style.  Pass all the options to amsbook
%% for processing.

\PassOptionsToClass{oneside}{amsbook}
\newif\if@nopunc\@nopuncfalse
\DeclareOption{nopunc}{\@nopunctrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\def\pdftex@true{0}    % Assume by default the graphics package uses dvips.
\DeclareOption{pdftex}{%
  \def\pdftex@true{1}% % If user employs pdflatex, include PDF images below.
}
\ProcessOptions\relax
\LoadClass{amsbook}

%% AMSBOOK bug corrections
%%
%% The current version of amsbook and amsart redefine this, but it breaks
%% minipage footnotes.  Put the core latex definition back.

\def\@makefnmark{\hbox{\@textsuperscript{\normalfont\@thefnmark}}}

%%\widowpenalty=10000
%%\clubpenalty=10000
%%\brokenpenalty=10000

%% MARGINS --- according to the PUC Thesis guidelines...
%% 
%% The left-hand margin must have a uniform width of not less than 38mm.
%% This rule also applies to diagrams, etc
%% The right-hand margin ... at approximately 25 mm width.
%% The upper and lower margins should be 25mm.
%%
%% leftmargin = 38mm - 1in = 38mm - 24.5mm = 12.6mm
%% rightmargin = 1in - 1in = 0mm
%%
\if@twoside %\ClassWarning{pucthesis}{--- TWO SIDED ---}
\oddsidemargin 14.6mm
\evensidemargin 0mm
\else %\ClassWarning{pucthesis}{--- ONE SIDED ---}
\oddsidemargin 14.6mm  % 38mm - 1in = 38mm  - 25.4mm = 12.6 mm
\evensidemargin\oddsidemargin
\fi

\textwidth 15.09cm % 8.5 in - 40mm (1.5in) - 25mm (1in)
\textheight = 21.44cm

\voffset = 1.02cm
\topmargin = 1cm %0in
\headheight = 0mm
\headsep = 0mm 
% \topskip 10pt
\footskip = 1cm

\normalparindent=21\p@
\parindent=\normalparindent
\parskip=5pt

%% DOUBLE SPACING -- use setspace.sty to double space the document.  It seems
%% to be compatible at this stage.  
%%

\RequirePackage{setspace}
\let\@normalsize=\normalsize
\def\baselinestretch{1.5}
\@currsize
\normalsize

%% When doing footnotes want the listi to behave differently.

\renewcommand\footnotesize{\Small
  \def\@listi{\topsep \z@ \parsep \z@ \itemsep \z@}}


%% UNIVERSITY LOGO 
%% 
\RequirePackage{ifpdf}
\ifpdf
    \RequirePackage[pdftex]{graphicx}
%    \RequirePackage{epstopdf}
\else
    \RequirePackage[dvips]{graphicx}
\fi


%% APA-style REFERENCES 2007.06.22
\RequirePackage{hyperref}
\RequirePackage{apacite}
%\renewcommand\newblock{\hspace{.7ex}}% Required because definition of
                                    % \bewblock in apacite.sty does not
                                    % leave enough space between the
                                    % the last author's initials and the year.


%% FLOAT PLACEMENT

\renewcommand{\topfraction}{.90}
\renewcommand{\bottomfraction}{.90}
\renewcommand{\textfraction}{.10}
\renewcommand{\floatpagefraction}{.90}
\renewcommand{\dbltopfraction}{.90}
\renewcommand{\dblfloatpagefraction}{.90}

%% AUXILIAR LENGTH
\newlength{\auxdist}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%  AMS logos
\newcount\TestCount
\def\AmS{{\the\textfont2 A}\kern-.1667em\lower.5ex\hbox
        {\the\textfont2 M}\kern-.125em{\the\textfont2 S}}
\def\AmSTeX{\AmS-\TeX}
\def\La{\TestCount=\the\fam \leavevmode L\raise.42ex
        \hbox{$\fam\TestCount\scriptstyle\kern-.3em A$}}
\def\LaTeX{\La\kern-.15em\TeX}
\def\AmSLaTeX{\AmS-\LaTeX}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%--add listoffigures and listoftables and use amsbook
\def\contentsname{TABLE OF CONTENTS}    
\def\listfigurename{LIST OF FIGURES}
\def\listtablename{LIST OF TABLES}

\def\proofname{Proof}
\def\chaptername{}%CHAPTER}
\def\thechapter{\@arabic\c@chapter} % Number chapters with arabic numerals.
\def\appendix{\par%
  \c@chapter\z@ \c@section\z@%
  \def\chaptername{APPENDIX}%
  \def\thechapter{\@Alph\c@chapter}} % Number appendix with uppercase letters.

%% This done by \newcounter{section}[chapter] in amsbook.  But cross
%% referencing should be fixed up, because right now references to a section
%% just produce the section number.  
%%
%% \@addtoreset{section}{chapter}  % There is probably a better way

%% If section is not numbered within chapter, changes should be done
%% in cimthesis.cls to produce a consistent section running head
%% throught the document.  See modification "modif. 20.May.2002"
%% (search without quotes) within this file.
%%
  \numberwithin{section}{chapter}
%%  \numberwithin{equation}{chapter} % equations are already numbered
                                    % within the chapter

%% Table of contents lines
%% Re-define to be dotted.

\c@tocdepth=2   % put subsections in toc.
\def\@toclevel{0} % Turn of error if \listoffigures not preceeded by \chap.
\def\l@subsection{\@tocline{2}{0pt}{2pc}{5pc}{}}
\def\@dotsep{4.5}
\def\@tocline#1#2#3#4#5#6#7{\relax
  \ifnum #1>\c@tocdepth % then omit
  \else
    \par \addpenalty\@secpenalty\addvspace{#2}%
    \begingroup \hyphenpenalty\@M
    \@ifempty{#4}{%
      \@tempdima\csname r@tocindent\number#1\endcsname\relax
    }{%
      \@tempdima#4\relax
    }%
    \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
    \rightskip\@pnumwidth plus1em \parfillskip-\@pnumwidth
    #5\leavevmode\hskip-\@tempdima #6\relax
    \nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill%
    \hbox to\@pnumwidth{\@tocpagenum{#7}}\par
    \nobreak
    \endgroup
  \fi}

%% Redefine list of figures and list of tables to allow for wider numbers. 
%% Included by MTT on 2008.06.25
%% Parameter 4 sets the tempdima in the routine tocline,
%% which in turn sets the numwidth.  See the 'tocloft' package documentation
%% for further insight.
\def\l@figure{\@tocline{0}{3pt plus2pt}{0pt}{2.3em}{}}
\let\l@table=\l@figure

%%%
%%% CHAPTER TITLES
%%%
\def\@chapter[#1]#2{\refstepcounter{chapter}%
  \ifnum\c@secnumdepth<\z@ \let\@secnumber\@empty
  \else \let\@secnumber\thechapter \fi
  \typeout{\chaptername\space\@secnumber}%
  \def\@toclevel{0}%
  \ifx\chaptername\appendixname \@tocwriteb\tocappendix{chapter}{#1}%
  \else \@tocwriteb\tocchapter{chapter}{#1}\fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}\@afterheading}

\def\@schapter#1{\typeout{#1}%
  \let\@secnumber\@empty
  \def\@toclevel{0}%
  \ifx\chaptername\appendixname \@tocwriteb\tocappendix{chapter}{#1}%
  \else \@tocwriteb\tocchapter{chapter}{#1}\fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makeschapterhead{#1}\@afterheading}

%-----------------------------------------------------from here
%-----------------------
%  add a switch to eliminate page numbers on first
%  chapter page  by making \thispagestyle{empty} 
%       modification: 17-aug-93
%
\def\NoChapterPageNumber{%
%  \def\chapter{\cleardoublepage \thispagestyle{empty} \pagestyle{headings}
  \def\chapter{\cleardoublepage \thispagestyle{onlypagenumber} \pagestyle{headings}
    \global\@topnum\z@
    %\@afterindentfalse % modif. 26.06.07 MTT - Uncomment to remove indent
                        % in the first after the beginning of each chapter.
    \secdef\@chapter\@schapter}}

%-----------------------
%  modify \chapter to put page numbers on top RHS of all
%  pages by changing  \thispagestyle{headings} 
%       modification: 17-aug-93
%
\def\chapter{\cleardoublepage \thispagestyle{headings} \pagestyle{headings}
  \global\@topnum\z@
  %\@afterindentfalse % modif. 26.06.07 MTT - Uncomment to remove indent
                      % in the first after the beginning of each chapter.
  \secdef\@chapter\@schapter}
%
%-----------------------
%   *** Modified \chapterhead to \huge instead of \LARGE fonts,
%   this should "bring to front" the title of the chapter 
%   as \LARGE and \Large of the section don't really visually
%   differ much.
%   *** REVERTED BACK TO \LARGE... as some titles do not fit nicely.
%   Also modified the vertical skip after the title to 16 units
%   instead of 36.
%   modif. 24.AUG.2002, by Miguel Torres-Torriti.
%   *** Modified \centering to comply with PUC Thesis Guidelines
%   modif. 07.MAY.2007, by Miguel Torres-Torriti.
%   It now checks if the chaptername is empty, if so then 
%   writes the chapter number and the title leaving a standard
%   space for the chapter number, otherwise sets the appropriate spacing
%   to write the chapter number, chapter name and title.
%   Also replaced \LARGE for \large, since PUC Thesis Guidelines require
%   \normalfont size to be 12pt.
%   modif. 26.JUN.2007, by Miguel Torres-Torriti.
%   Back to square one... lowering standards as requested by the ORGS. :(
%   Replaced \large for nothing (normalfont), since PUC Thesis Guidelines 
%   require \normalfont size to be 12pt.  
\def\@makechapterhead#1{
  \global\topskip 0.5cm\relax
  \begingroup\normalfont\bfseries
  \rlap {
  \vbox to\z@ {
    \vss {
      \mdseries\@normalsize%
      \ifx \chaptername\empty%
	\settowidth{\auxdist}{\bfseries \thechapter.\enspace}%
	\addtolength{\auxdist}{-\textwidth}%  
	\setlength{\auxdist}{-\auxdist}%
	{\noindent\bfseries \thechapter.\enspace\parbox[t]{\auxdist}{\uppercase{#1}}}%
      \else%
	\settowidth{\auxdist}{\bfseries \chaptername\space \thechapter.\enspace}%
	\addtolength{\auxdist}{-\textwidth}%  
	\setlength{\auxdist}{-\auxdist}%
	{\noindent\bfseries \chaptername\space \thechapter.\enspace\parbox[t]{\auxdist}{\uppercase{#1}}}%
      \fi%
      \enspace
      }%
    }
  }%
  \vskip 22pt%
  \par
  \endgroup
  \skip@16\p@ \advance\skip@-\normalbaselineskip%
  \vskip\skip@%
}

\def\@makeschapterhead#1{\global\topskip 0pc\relax
  \begingroup\normalfont\bfseries%\large% modif. 26.06.07 MTT
  \centering\uppercase{#1}% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   left justify chapter head the next 5 lines replaces
%%     \centering#1\par 
%%\leftline{#1}          %chapterfont
%%\vskip 0pt
%%   \vbox{\hrule width \hsize}    
%%   \vskip 42pt
     \vskip 22pt
\par
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endgroup
\ifx#1\contentsname\skip@36\p@
        \else
\ifx#1\bibname\skip@36\p@
         \else
                 \skip@36\p@ %%%¥was 55
        \fi
  \fi
\advance\skip@-\normalbaselineskip
  \vskip\skip@ 
}
%-----------------------------------------------------to here



%%      Sectioning commands

%% The "." after subsection name is not kosher according to MDL
%% But others say that it is (including AMS apparently).

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
  \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
  \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
 \ifnum #2>\c@secnumdepth
   \let\@svsec\@empty
 \else
    \refstepcounter{#1}%
    \edef\@svsec{\ifnum#2<\@m
       \@ifundefined{#1name}{}{%
         \ignorespaces\csname #1name\endcsname\space}\fi
       \@nx\textup{%
         \csname the#1\endcsname.}\enspace
    }%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@ % then this is not a run-in section heading
    \begingroup #6\relax
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8\par}%
    \endgroup
  \csname #1mark\endcsname{#7}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
  \else
  \def\@svsechd{#6\hskip #3\@svsec
    \@ifnotempty{#8}{\ignorespaces#8\unskip\if@nopunc\else\@addpunct.\fi}
    \ifnum#2>\@m\else\@tocwrite{#1}{#8}\fi
  }%
  \fi
  \global\@nobreaktrue
  \@xsect{#5}}

%% Old section spacing was hardwired.  Make them depend on the font
%% size like amsbook.  (Still not sure if this is best though).

%% \def\section{\@startsection{section}{1}%
%%   \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
%%   {\normalfont\bfseries\large}}

%% \def\subsection{\@startsection{subsection}{2}%
%%   \normalparindent{.5\linespacing\@plus.5\linespacing}{-1em}%
%%   {\normalfont\bfseries}}

%% \def\subsubsection{\@startsection{subsubsection}{3}%
%%   \normalparindent\z@{-1em}%
%%   {\normalfont\itshape}}

%% Redefined section, subsection and subsubsection as above.
%% modif. 24.AUG.2002, by Miguel Torres-Torriti.

\def\section{\@startsection{section}{1}%
  \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\bfseries}} %\large}} % originally \Large

\def\subsection{\@startsection{subsection}{2}%
  \z@{.5\linespacing\@plus.5\linespacing}{.1\linespacing}%
  {\normalfont\bfseries}} % originally \large

\def\subsubsection{\@startsection{subsubsection}{3}%
  \z@{.0\linespacing\@plus.2\linespacing}{.01\linespacing}%
  {\normalfont\bfseries}}

\def\paragraph{\@startsection{paragraph}{4}%
  \z@{-\fontdimen2\font}%
  \normalfont}

\def\subparagraph{\@startsection{subparagraph}{5}%
  \z@\z@{-\fontdimen2\font}%
  \normalfont}

%
%      Set \topsep to 0 in \@listI.
\def\@listI{\leftmargin\leftmargini
  \parsep\z@skip \topsep\z@skip \itemsep\z@skip}
\let\@listi\@listI
\@listi
%

%% THEOREM STYLES -- These are controlled by the \th@* definition which can be
%%  found in amsbook.cls.  Lets just go with the amsbook defaults until
%%  someone objects. 


%%%
%%% HEADER and FOOTER
%%%
\let\sectionmark\@gobble % Just to have chapter name...
%%
%% Want section running head to be numbered with chapter as well.
%%
%% modif. 20.May.2002, by Miguel Torres-Torriti:
%%   Eliminated "\thechapter." since section is already numbered
%%   within chapter when \numberwithin{section}{chapter} is used
%%   in the preamble ("\thechapter." should be used if sections
%%   are not numbered as 'chapter #.section #' to produce consistent
%%   section running heads throught the document).
%% modif. 15.Aug.2002, by Miguel Torres-Torriti:
%%   Added "." after "#2"  -  Now numbers of chapter and section
%%   in the headings are consistent.
%%   e.g.  Even Page: CHAPTER 123. Chapter Title
%%          Odd Page:         123.2. Section Title
%%               
\def\sectionrunhead#1#2#3{%
  \@ifnotempty{#2}{{#1 %\thechapter.
#2.}\@ifnotempty{#3}{\hskip1em}}
  \def\@tempa{#3}%
  \ifx\@empty\@tempa\else\uppercasenonmath\@tempa\@tempa\fi}
%%
%% \pagestyle{onlypagenumber} MTT modif. 07.05.2007 for PUC Thesis
%%
\def\ps@onlypagenumber{\ps@empty
  \def\@oddfoot{\normalsize\hfil\llap{\thepage}}
  \def\@evenfoot{\normalsize\rlap{\thepage}{}{}\hfil}}%
%%
%% \pagestyle{headings}
%%
\def\ps@headings{\ps@empty
  \def\@oddfoot{\normalsize\hfil\llap{\thepage}}
  \def\@evenfoot{\normalsize\rlap{\thepage}{}{}\hfil}
%% modif. 18.May.2007, by Miguel Torres-Torriti:
%% Disabled even/odd, part, chapter, section head marks to
%% to comply with PUC Thesis Guidelines.
%%%  \def\@evenhead{\Small\rlap{\leftmark}\hfil}
%%%  \def\@oddhead{\Small\hfil{\rightmark}}
  \let\@mkboth\markboth
%%%  \def\partmark{\@secmark\markboth\partrunhead\partname}%
%%%  \def\chaptermark{\@secmark\markboth\chapterrunhead\chaptername}%
%%%  \def\sectionmark{\@secmark\markright\sectionrunhead\sectionname}%
  }%
%%
%% \pagestyle{myheadings}
%%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
  \def\@oddhead{\hfil\Small\rightmark\hbox{} }
  \def\@oddfoot{\rm\hfil\thepage\hbox{}}
  \let\@evenhead\@oddhead
  \let\@evenfoot\@oddfoot\def\sectionmark##1{}\def\subsectionmark##1{}
  \def\chaptermark##1{\markright {\ifnum \c@secnumdepth
      >\m@ne
      \thechapter. \ ##1\fi}}}

%%% DRAFT mode --- all it does is to change the heading styles

\def\draft{%
  \textwidth 6in
  \oddsidemargin 0mm
  \evensidemargin 12.6mm
  \doublespacing
  \linespread{1.5}
  %%
  %% \pagestyle{headings} (draft)
  %%
  \def\ps@headings{
    \def\@oddfoot{\normalfont
    \footnotesize 
    \textit{\svnInfoFile~
    Rev:\,{\svnInfoRevision}\,({\svnInfoMinRevision}:\,{\svnInfoMaxRevision}),\,{\svnInfoDate}}
    \hfil \normalsize \thepage}

    \def\@evenfoot{\normalfont 
    \normalsize \thepage \hfil
    \footnotesize 
    \textit{\svnInfoFile~
    Rev:\,{\svnInfoRevision}\,({\svnInfoMinRevision}:\,{\svnInfoMaxRevision}),\,{\svnInfoDate}}
    }

    \def\@evenhead{\null}
    \def\@oddhead{\null}}%
  %%
  %% \pagestyle{myheadings} (draft)
  %%
  \def\ps@myheadings{\let\@mkboth\@gobbletwo
    \def\@oddfoot {\null\normalfont\footnotesize
      \hfil
      \textit{\svnInfoFile~
      Rev:\,{\svnInfoRevision}\,({\svnInfoMinRevision}:\,{\svnInfoMaxRevision}),\,{\svnInfoDate}}
      \hfil}          
    \def\@evenfoot{\null\normalfont\footnotesize
      \hfil
      \textit{\svnInfoFile~
      Rev:\,{\svnInfoRevision}\,({\svnInfoMinRevision}:\,{\svnInfoMaxRevision}),\,{\svnInfoDate}}
      \hfil}        
    \def\@oddhead{\null\normalfont\normalsize\rm\rightmark \hfil\thepage}%
    \def\@evenhead{\normalfont\normalsize\rm\thepage\hfil\leftmark\null}}
  \ps@headings
}

%----------------------------
%
%       Some computations to make the \textheight come out
%       to an even multiple of baselineskip (after taking
%       \topskip etc. into account).
\advance\textheight by -\headheight
\advance\textheight by -\headsep
\advance\textheight by -\normalbaselineskip
\advance\textheight by \topskip

%
%       We now have the right value for \textheight except that
%       we need to round it.
\advance\textheight by.5\normalbaselineskip
\divide\textheight by\normalbaselineskip
\multiply\textheight by\normalbaselineskip
%       One last note: if \baselinestretch is changed in an
%       actual document, this \textheight will most likely be
%       off and you'll get underfull vbox messages.
%
\advance\topmargin by -.25 true in
%
%      LIST ENVIRONMENTS
%
%      Change first-level `enumerate' numbering style from arabic
%      to roman numeral.
\renewcommand{\labelenumi}{(\roman{enumi})}
%
%      Change \enumerate and \itemize to increase \partopsep.
\def\enumerate{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
    {\@enumctr}\partopsep6\p@\def\makelabel##1{\hss\llap{\upshape##1}}}\fi}
%
\def\itemize{\ifnum\@itemdepth>3 \@toodeep
  \else \advance\@itemdepth\@ne
  \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
  \list{\csname\@itemitem\endcsname}%
  {\partopsep6\p@\def\makelabel##1{\hss\llap{\upshape##1}}}\fi}
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\def\refname{REFERENCES}
\def\bibname{}      
%      Change the font of `References' head.
\def\thebibliography#1{\vspace{1pc}
       \chapter*\refname   %%%%%\section*{\series m\scshape\refname}%
%      Now we need to reset the running heads because we don't
%      wan't them to contain the font reference \series m\scshape.
  \edef\@tempa{{\noexpand\@mkboth{\refname}{\refname}}}%
  \@tempa
  \normalfont\labelsep .5em\relax
  \list{[\@arabic\c@enumi]\quad}{\settowidth\labelwidth{[#1]\quad}%
  \itemsep \baselineskip %MTT 2008.06.25
  \leftmargin\labelwidth \advance\leftmargin\labelsep
  \usecounter{enumi}}%
  \sloppy 
  \sfcode`\.\@m}

\def\@bibitem#1{\item\if@filesw \immediate\write\@auxout
       {\string\bibcite{#1}{\the\c@enumi}}\smallskip\fi\ignorespaces}



%%%%%%%%%%%%%%%%%%%%%%%%%-------page i-iii ------%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------%
%
%      TOPMATTER 
%
%      In \@maketitle we make the following changes:
%
%      \topskip --> 7pc(=84\p@) - headheight - headsep
%      title --> 10/14, uppercased
%      author --> aboveskip = 32pt, normalsize instead of small

\def\@maketitle{%
\clearpage  \thispagestyle{empty}  
\begingroup
  \normalfont\normalsize
  \topskip0\p@  % 
  \advance\topskip-\headsep \advance\topskip-\headheight
  \vskip12\p@\@plus12\p@
  \vspace*{-20mm}
  %%
  %% University/School/Department
  %%
  \vtop{%\centering
       {%
       \noindent
       %\parbox[t]{70pt}{\rule[-48pt]{72pt}{72pt}}
%       \raisebox{-22.13mm}[0em][0em]
%       {            
        %\hspace{80pt}
        %    \raisebox{29.38mm}[0em][0em]{%
        %                 \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        % --- Draw vertical left edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[-\textheight]{.0pt}{\textheight}}\\[-\normalbaselineskip]
        % --- Draw horizontal top edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[0pt]{\textwidth}{.0pt}}\\[-\normalbaselineskip]
        % --- Draw vertical decorative line ---
        \hspace*{80pt}%
        %\rule[0em]{80pt}{0pt}%       
        % Note: Must use a trailing '%' 
        % otherwise a small space will be added due to the line feed.
        \vspace*{-4mm}%
        \setlength{\auxdist}{\textheight}%
        \addtolength{\auxdist}{19mm}%
        \raisebox{4mm}[0em][0em]{%
                         \rule[-\auxdist]{.5pt}{\auxdist}}\\[-0\normalbaselineskip]
        \hspace*{-7.5mm}% shif left half 13mm-off-margin
        \parbox{80pt}
        {\centering %\rule[0em]{80pt}{1ex}\\
            \includegraphics*[height=30.38mm,width=23mm]{logopuc}\\[.2\normalbaselineskip]
%            \raisebox{29.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
%            \raisebox{17.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        }%
       \hspace{7.5mm}% shif right to compensante left-shift and 13mm-off-margin
       \hspace{20pt}%
       \parbox{.75\textwidth}{%parbox 2
       \@university\\
       \@school%\\
       \ifx\@empty\@department {}%{Department of .........}
       \else{\\\@department}\fi}\\ %end parbox 2
       % --- Draw horizontal decorative line ---
       \setlength{\auxdist}{\textwidth}%
       \addtolength{\auxdist}{13mm}%
       \addtolength{\auxdist}{15mm}%
       \hspace*{-13mm}%
       \rule[0pt]{\auxdist}{.5pt}
       }%end centering
     } %end vtop
  \vskip105\p@\@plus24\p@
  %%
  %% Title
  %%
  \setlength{\auxdist}{\textwidth}%
  \addtolength{\auxdist}{-120pt}%
  \addtolength{\auxdist}{15mm}%
  \vtop{%\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       \uppercasenonmath{\@title}
       \bfseries\Large%\LARGE
       \@title\@@par}%end parbox
       }%end centering
     % \global\dimen@i\prevdepth
     }%end vtop
  \prevdepth\dimen@i
  \vskip65\p@%
  %%
  %% Author(s)
  %%
  %\hspace{80pt}
  %\parbox[t]{.75\textwidth}{\centering
  \ifx\@empty\authors\else
    \vtop{\andify\authors
      %\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       {\bfseries\large\MakeUppercase\authors}\@@par}%end parbox
       }%
      %\global\dimen@i\prevdepth
     }\relax%
   %}%end parbox
   \prevdepth\dimen@i
  \fi
  \vskip15\p@\@plus12\p@
  %%
  %% Blah, Blah...
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{
      \noindent
      Thesis submitted to the Office of Research and Graduate Studies\\ 
      in partial fulfillment of the requirements for the degree of\\
      \ifx\@empty\@degree {.........}\else\@degree\fi}%end parbox
      }%end centering
    }
  \vskip10\p@\@plus14\p@
  %%
  %% Advisor
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{%
      \noindent
      Advisor:\\
      {%\large 
      \ifx\@empty\@advisor {.........}\else{\uppercase\@advisor}\fi}}%end parbox
      }%end centering
    }
  \vskip5\p@\@plus14\p@
  %%
  %% The date
  %%
  %\centerline{\rm\ifx\@empty\@date {\MoYr}\else\@date\fi}
  \vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \rm Santiago de Chile, \ifx\@empty\@date {\MoYr}\else\@date\fi
  }%end parbox
  \vskip5\p@\@plus14\p@
  %\vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \copyrightline}%end parbox
\endgroup
\clearpage  \thispagestyle{empty}

%% 
%% Copyright page, according to rules by the Library
%%
\copyrightline

Se autoriza la reproducci\'on total o parcial, con fines acad\'emicos, por
cualquier medio o procedimiento, incluyendo la cita bibliogr\'afica que
acredita al trabajo y a su autor.

%%
%%
%% Repreat title page, but now include all committee members.
%%
%%
\cleardoublepage  \thispagestyle{empty}  
\begingroup
  \normalfont\normalsize
  \topskip0\p@  % 
  \advance\topskip-\headsep \advance\topskip-\headheight
  \vskip12\p@\@plus12\p@
  \vspace*{-20mm}
  %%
  %% University/School/Department
  %%
  \vtop{%\centering
       {%
       \noindent
       %\parbox[t]{70pt}{\rule[-48pt]{72pt}{72pt}}
%       \raisebox{-22.13mm}[0em][0em]
%       {            
        %\hspace{80pt}
        %    \raisebox{29.38mm}[0em][0em]{%
        %                 \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        % --- Draw vertical left edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[-\textheight]{.0pt}{\textheight}}\\[-\normalbaselineskip]
        % --- Draw horizontal top edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[0pt]{\textwidth}{.0pt}}\\[-\normalbaselineskip]
        % --- Draw vertical decorative line ---
        \hspace*{80pt}%
        %\rule[0em]{80pt}{0pt}%       
        % Note: Must use a trailing '%' 
        % otherwise a small space will be added due to the line feed.
        \vspace*{-4mm}%
        \setlength{\auxdist}{\textheight}%
        \addtolength{\auxdist}{19mm}%
        \raisebox{4mm}[0em][0em]{%
                         \rule[-\auxdist]{.5pt}{\auxdist}}\\[-0\normalbaselineskip]
        \hspace*{-7.5mm}% shif left half 13mm-off-margin
        \parbox{80pt}
        {\centering %\rule[0em]{80pt}{1ex}\\
            \includegraphics*[height=30.38mm,width=23mm]{logopuc}\\[.2\normalbaselineskip]
%            \raisebox{29.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
%            \raisebox{17.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        }%
%       }
       \hspace{7.5mm}% shif right to compensante left-shift and 13mm-off-margin
       \hspace{20pt}%
       \parbox{.75\textwidth}{%parbox 2
       \@university\\
       \@school%\\
       \ifx\@empty\@department {}%{Department of .........}
       \else{\\\@department}\fi}\\ %end parbox 2
       % --- Draw horizontal decorative line ---
       \setlength{\auxdist}{\textwidth}%
       \addtolength{\auxdist}{13mm}%
       \addtolength{\auxdist}{15mm}%
       \hspace*{-13mm}%
       \rule[0pt]{\auxdist}{.5pt}
       }%end centering
     } %end vtop
  \vskip100\p@\@plus24\p@
  %%
  %% Title
  %%
  \setlength{\auxdist}{\textwidth}%
  \addtolength{\auxdist}{-120pt}%
  \addtolength{\auxdist}{15mm}%
  \vtop{%\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       \uppercasenonmath{\@title}
       \bfseries\Large%\LARGE
       \@title\@@par}%end parbox
       }%end centering
     % \global\dimen@i\prevdepth
     }%end vtop
  \prevdepth\dimen@i
  \vskip60\p@%
  %%
  %% Author(s)
  %%
  %\hspace{80pt}
  %\parbox[t]{.75\textwidth}{\centering
  \ifx\@empty\authors\else
    \vtop{\andify\authors
      %\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       {\bfseries\large\MakeUppercase\authors}\@@par}%end parbox
       }%
      %\global\dimen@i\prevdepth
     }\relax%
   %}%end parbox
   \prevdepth\dimen@i
  \fi
  \vskip15\p@\@plus12\p@
  %%
  %% Members of the Committee
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{%
      \noindent
      Members of the Committee:\\
      {\normalsize
      \ifx\@empty\@advisor {.........}\\\else{\uppercase\@advisor}\\\fi
      \ifx\@empty\@committeememberA {.........}\\\else{\uppercase\@committeememberA}\\\fi
      \ifx\@empty\@committeememberB {}\else{\uppercase\@committeememberB}\\\fi
      \ifx\@empty\@guestmemberA {.........}\\\else{\uppercase\@guestmemberA}\\\fi
      \ifx\@empty\@guestmemberB {}\else{\uppercase\@guestmemberB}\\\fi
      \ifx\@empty\@ogrsmember {.........}\else{\uppercase\@ogrsmember}\fi}
      }%end parbox
      }%end centering
    }
  \vskip5\p@\@plus14\p@
  %%
  %% Blah, Blah...
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{
      \noindent
      Thesis submitted to the Office of Research and Graduate Studies\\ 
      in partial fulfillment of the requirements for the degree of\\
      \ifx\@empty\@degree {.........}\else\@degree\fi}%end parbox
      }%end centering
    }
  \vskip10\p@\@plus14\p@
  %%
  %% The date
  %%
  %\centerline{\rm\ifx\@empty\@date {\MoYr}\else\@date\fi}
  \vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \rm Santiago de Chile, \ifx\@empty\@date {\MoYr}\else\@date\fi
  }%end parbox
  \vskip5\p@\@plus14\p@
  %\vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \copyrightline}%end parbox
\endgroup
\clearpage  \thispagestyle{empty}
%% %
%%
%%
%% Make dedication page if declared.
%%
%%
 \ifx \@empty\@dedication {}%if not defined or empty do nothing 
 \else
 \cleardoublepage  \thispagestyle{empty}
 \begingroup
 ~\vspace*{.7\textheight}\\[-\normalbaselineskip]%
 \mbox{}\hspace*{0.6\textwidth}%
 \parbox[t]{0.4\textwidth}{\centering% 
 {\em \@dedication}}
 \endgroup
 \clearpage \thispagestyle{empty}
 \fi%
} % end \@maketitle



%
%-----parameters to be set up in the document------------------------- 
%
\def\mdate#1{\def\@mdate{{#1}}}
\def\@mdate{}
\def\version#1{\def\@version{{#1}}}
\version{0}

\def\university#1{\def\@university{{\normalfont#1}}}
\university{PONTIFICIA UNIVERSIDAD CATOLICA DE CHILE} % originally \large
%
\def\school#1{\def\@school{{\normalfont#1}}}
\school{SCHOOL OF ENGINEERING} % originally \large
%
\def\facultyto#1{\def\@facultyto{{\normalfont\rm#1}}}
\facultyto{{\rm School of Engineering}}
%
\def\department#1{\def\@department{{\normalfont\rm#1}}}
\def\@department{}
%
\def\faculty#1{\def\@faculty{{\normalfont\rm#1}}}
\def\@faculty{}
%
\def\advisor#1{\def\@advisor{{\normalfont\rm#1}}}
\def\@advisor{}
%
\def\committeememberA#1{\def\@committeememberA{{\normalfont\rm#1}}}
\def\@committeememberA{}
%
\def\committeememberB#1{\def\@committeememberB{{\normalfont\rm#1}}}
\def\@committeememberB{}
%
\def\guestmemberA#1{\def\@guestmemberA{{\normalfont\rm#1}}}
\def\@guestmemberA{}
%
\def\guestmemberB#1{\def\@guestmemberB{{\normalfont\rm#1}}}
\def\@guestmemberB{}
%
\def\ogrsmember#1{\def\@ogrsmember{{\normalfont\rm#1}}}
\def\@ogrsmember{}
%
\def\date#1{\def\@date{{\normalfont\rm#1}}}
\def\@date{}
%
\def\copyrightname#1{\def\@copyrightname{{\scshape#1}}}
\def\@copyrightname{}
%
\def\copyrightyear#1{\def\@copyrightyear{{\normalfont\footnotesize#1}}}
\def\@copyrightyear{}
%
\def\copyrightline{%
  %\centerline
    {\footnotesize \raisebox{.2ex}{$\copyright$} %${}^{\hbox{\copyright}}$ 
    \@copyrightyear, %
    \ifx\@copyrightname\empty{..........}\else 
    {\@copyrightname}\fi%         
    }%end centerline
                  }
%
\def\prepresentedto{\vskip1.75pc}
%
\def\degree#1{\def\@degree{{\normalfont\rm#1}}}
\def\@degree{}
%
\def\subject#1{\def\@subject{{\normalfont\rm#1}}}
\def\@subject{}
%
\def\shortauthors{}
\def\shorttitle{}
%
\def\dedication#1{\def\@dedication{#1}}
\def\@dedication{}
%

%
%------------------\maketitle creates cover page---------------------
%
\def\maketitle{\par
  \@topnum\z@ % this prevents figures from falling at the top of page 1
  \ifx\@empty\shortauthors\let\shortauthors\shorttitle\fi
  \begingroup
  \@maketitle
  \endgroup
  \andify\shortauthors
  \thispagestyle{headings}%             %¥modification 17-aug-93
  \c@footnote\z@
%
%  the following commands free up memory for small systems
%  once \maketitle is over
%  but keep authors and title for future use
%
  \def\do##1{\let##1\relax}%
  \do\maketitle \do\@maketitle
% \do\title \do\@xtitle \do\@title      %¥modification
% \do\author \do\@xauthor \do\@authors  %¥modification
  \do\address \do\@xaddress
  \do\email \do\@xemail \do\curraddr \do\@xcurraddr
%
  \do\department \do\@department
  \do\faculty \do\@faculty
  \do\degree \do\@degree
  \do\subject \do\@subject
  \do\date \do\@date
  \do\copyrightyear \do\@copyrightyear
}
%
%%%%%%%%%%%%%%%%%%%%%%%%-------end of cover page------%%%%%%%%%%%%%%%%%%%%%%%%
%

% this is for hanging indent of turn lines in current address
\newbox\checkbox
\setbox\checkbox=\hbox{{\ignorespaces\footnotesize\it
                \indent Current address}:\ }

%% v1.0
%%
%% This is exactly as in amsbook.cls.
%% \addresses will be a list of things like "\author{Electron Blues}
%% \address{PUC} \email{eblues} \author{Math Monster} \address{PUC}
%% \email{mmonster}", and \@setaddresses is used to define the way
%% \author,\address,etc do the printing when \addresses is expanded.
%%

\def\@setaddresses{\par
  \nobreak \begingroup \footnotesize
  \def\author##1{\nobreak\addvspace\bigskipamount}%
  \def\\{\unskip, \ignorespaces}%
  \interlinepenalty\@M
  \def\address##1##2{\begingroup
    \par\nobreak %\addvspace\medskipamount\indent
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\noindent \scshape\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape Current address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape E-mail address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par\endgroup}}%
  \addresses
  \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of \@setaddress


% We just wanted to lower the caption size to 10pt

%\def\floatfontsize{\@setsize\footnotesize{11\p@}\xpt\@xpt%
%  \abovedisplayskip 2\p@ \@plus 1.5\p@ minus1.5\p@%
%  \belowdisplayskip \abovedisplayskip
%  \abovedisplayshortskip \z@ \@plus 2\p@%
%  \belowdisplayshortskip 2\p@ \@plus 1\p@ minus1\p@%
%  \def\@listi{\topsep \z@ \parsep \z@ \itemsep \z@}}

\def\@captionheadfont{\scshape}
\def\@captionfont{\normalfont\small}

%------------------------------- 
\def\today{\number\day\space%           Day month and year
    \ifcase\month
    \or January\or February\or March\or April\or May\or June%
    \or July\or August\or September\or October\or November\or December%
    \fi%
    \space\number\year}%
%------------------------------- 
\def\Month{%
    \ifcase\month
    \or January\or February\or March\or April\or May\or June%
    \or July\or August\or September\or October\or November\or December%
    \fi}%
%------------------------------- 
\def\Year{\number\year}
%===================================================FRENCH 
\def\MoYr{%
    \ifcase\month
    \or January\or February\or March\or April\or May\or June%
    \or July\or August\or September\or October\or November\or December%
    \fi%
    \space\number\year}%
%------------------------------- 
\def\todayfr{\space\number\day\space
             \ifcase\month
             \or
  janvier\or f\'evrier\or mars\or avril\or mai\or juin\or
  juillet\or ao\^ut\or septembre\or octobre\or novembre\or d\'ecembre\fi
  \space \number\year}
%=================================================== 
\def\MoYrfr{%
    \ifcase\month\or
  janvier\or f\'evrier\or mars\or avril\or mai\or juin\or
  juillet\or ao\^ut\or septembre\or octobre\or novembre\or d\'ecembre
    \fi%
    \space\number\year}%
%------------------------------- 
\def\hhmm{%
    \count1=\time                  % current time in minutes after 00:00
    \count2=\count1                % count 2 contains time in minutes
    \divide \count1 by 60          % count1  contains hh in hours
    \count3=\count1                % count3  contains hh in hours
    \multiply \count1 by 60        % count1  contains hh in minutes
    \advance\count2 by -\count1    % count2  contains mm in minutes
                                   % do NOT put a space after<\advance>  
    \number\count3:\number\count2  % print hours:minutes
   }
%------------------------------- 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   %                                                               %
   %  Copy of \verbinput : to make listing of TeX files.
   %  Received from M.J. Downes, AMS techsupport group, 8 Apr. 1992     
   %                                                               %
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

\begingroup
\lccode`\~=`\ % actually, this percent sign is required
\lowercase{\gdef\verbspaces{\obeyspaces
  \def~{\leavevmode\space}}}
\endgroup
 
\def\verbinput#1{%
% Start a group to keep catcode changes localized.
  \begingroup
% Change the definition of \do so that it will do what we
% want when \dospecials is called.
  \def\do##1{\catcode`##1=12}%
  \dospecials \catcode`\@=12 % \@ is not in \dospecials
  \verbspaces
  \def\par{\ifvmode\null\else\endgraf\fi}\obeylines
% Uncomment this line if you don't want the verbatim lines indented:
%  \parindent0pt
  \Small\tt         %%% \eightpoint\tt in amstex
  \input #1\relax
  \endgroup}
%-------------------------------
%%%%  Usage: 
%%%%    \verbinput{myfile.tex}
%------------------------------- 

\def\verbinputx[#1]#2{%
% Start a group to keep catcode changes localized.
  \begingroup
% Change the definition of \do so that it will do what we
% want when \dospecials is called.
  \def\do##1{\catcode`##1=12}%
  \dospecials \catcode`\@=12 % \@ is not in \dospecials
  \verbspaces
  \def\par{\ifvmode\null\else\endgraf\fi}\obeylines
% Uncomment this line if you don't want the verbatim lines indented:
%  \parindent0pt
  \Small\tt         %%% \eightpoint\tt in amstex
  {#1%
  \input #2\relax
  }%
  \endgroup}
%-------------------------------
%%%%  Usage: 
%%%%    \verbinputx[fontsize]{myfile.tex}
%%%%  where fontsize can be any of \LaTeX font size adjusting commands, e.g.
%%%%  \tiny, \footnotesize, \scriptsize, \small, \normalsize, \large, etc.
%------------------------------- 

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\def\enddocument{\@checkend{document}\par
%% \vfill
%% \eject
%% \pagestyle{empty}
%% %
%% %============================================================
%%   \ifx\@empty\@translators \else
%%     \addvspace{6\p@\@plus9\p@}%
%%     \hbox to\columnwidth{\hss\normalfont\normalsize 
%%      Translated by 
%%        \expandafter\uppercasenonmath\expandafter{\@translators}}%
%%   \fi
%% %      Typeset the address, current address, email address:
%% %-----------------
%%  \topskip56pt % 
%% \leftline{{\bfseries\large Document Log:}}
%% \vskip28pt
%%   \vbox{\centering{Manuscript Version \@version%
%%            \ifx\@empty\@mdate\else\,---\,\@mdate \fi}%
%%   }
%%   \vbox{\centering{Typeset by {\AmSLaTeX}\,---\,\today}
%%   }
%% \vskip 28pt
%% %-----------------
%%   \vtop{\centering{\bfseries%
%%         \expandafter\uppercasenonmath\expandafter{%
%%                     \bfseries\large\@title}\@@par}%
%%         \global\dimen@i\prevdepth}\relax%
%% \vskip 42pt
%%         \ifx\@empty\authors
%%         \else
%%         \centerline{\andify\authors{\scshape\authors}}%
%%         \fi
%% %-----------------
%% \vfill \null
%% \@setaddresses
%% \vspace{1cm}
%% \rightline{Typeset by {\AmSLaTeX}}

%============================================================
% The following lines seem to have been inherited from amsart.sty 
% ver. 1.1b", 31-JUL-1991.  The line \def\global does not have
% any sense and produces clashes with apacite ver. 4 2007.
% Thanks must go to Erik Meijer, author of apacite who figured
% out were the problem was.
% MTT 2008.12.12
 \clearpage\begingroup  
 \if@filesw \immediate\closeout\@mainaux 
 %\def\global\@namedef##1##2{}% bad definition
 %\global\def\@namedef##1##2{}% use this instead of previous one if necessary 
 \def\newlabel{\@testdef r}%
 \def\bibcite{\@testdef b}\@tempswafalse \makeatletter\input \jobname.aux
 \if@tempswa \@warning{Label(s) may have changed.  Rerun to get
 cross-references right}\fi\fi\endgroup\deadcycles\z@\@@end}

\ps@headings
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}
\numberwithin{equation}{chapter}

\endinput
%------------------------------------------------------------------------------
% End of pucthesis.cls
%------------------------------------------------------------------------------
