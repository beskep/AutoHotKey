#Requires AutoHotkey v2.0

control := true
hotstrings := true
wheel_down := 'None' ; {'None', '{LButton}', '{Space}'}

TimeoutTrayTip(text, title := '', option := '', time := 1000) {
    TrayTip text
    SetTimer TrayTip, -time
}

^!+1::
{
    global control
    control := !control
    TimeoutTrayTip('Control: ' . (control ? "On" : "Off"))
}

^!+2::
{
    global hotstrings
    hotstrings := !hotstrings
    TimeoutTrayTip('Hotstrings: ' . (hotstrings ? "On" : "Off"))
}

^!+3::
{
    global wheel_down
    wheel_down := 'None'
    TimeoutTrayTip('WheelDown: ' . wheel_down)
}

^!+4::
{
    global wheel_down
    wheel_down := wheel_down = '{LButton}' ? 'None' : '{LButton}'
    TimeoutTrayTip('WheelDown: ' . wheel_down)
}

^!+5::
{
    global wheel_down
    wheel_down := wheel_down = '{Space}' ? 'None' : '{Space}'
    TimeoutTrayTip('WheelDown: ' . wheel_down)
}

#HotIf control
{
    ; Capslock
    +Capslock::Capslock
    Capslock::Ctrl

    ; Mouse
    XButton2:: Send '^{w}'

    ; Alt control
    !i:: Send '{Up}'
    !k:: Send '{Down}'
    !j:: Send '{Left}'
    !l:: Send '{Right}'

    ; Volume
    ^!PgDn:: Send '{Volume_Down}'
    ^!PgUp:: Send '{Volume_Up}'

    ; Hotstring
    :?*:\today\::
    {
        SendText FormatTime(, "yyyy-MM-dd")
    }
    :?*:\now\::
    {
        SendText FormatTime(, "yyyy-MM-dd HH:mm:ss")
    }
    :?*:\nowb\::
    {
        ; basic format
        SendText FormatTime(, "yyyyMMdd'T'HHmmss")
    }
    :?*:\nowc\::
    {
        ; 콜론 제외 (파일명에 사용)
        SendText FormatTime(, "yyyy-MM-dd HHmmss")
    }
}

#HotIf hotstrings
{
    ; general
    :?*:\ndash\::–            ; U+2013 EN DASH
    :?*:\mdash\::—            ; U+2014 EM DASH
    :?*:\horbar\::―           ; U+2015 HORIZONTAL BAR
    :?*:\middot\::·           ; U+00B7 MIDDLE DOT
    :?*:\bullet\::•           ; U+2022 BULLET
    :?*:\laquo\::«            ; U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    :?*:\raquo\::»            ; U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    :?*:\cross\::⨯            ; U+2A2F VECTOR OR CROSS PRODUCT
    :?*:\check\::✓            ; U+2713 CHECK MARK
    :?*:\mdot\::·             ; U+00B7 MIDDLE DOT
    :?*:\bulletop\::∙         ; U+2219 BULLET OPERATOR
    :?*:\degc\::℃             ; U+2103 DEGREE CELSIUS
    :?*:\lcb\::「              ; U+300C LEFT CORNER BRACKET
    :?*:\rcb\::」              ; U+300D RIGHT CORNER BRACKET
    :?*:\lwcb\::『             ; U+300E LEFT WHITE CORNER BRACKET
    :?*:\rwcb\::』             ; U+300F RIGHT WHITE CORNER BRACKET
    :?*:\heavycheck\::✔       ; U+2714 HEAVY CHECK MARK
    :?*:\heavymul\::✖         ; U+2716 HEAVY MULTIPLICATION X
    :?*:\ballotbox\::☐        ; U+2610 BALLOT BOX
    :?*:\ballotcheck\::☑      ; U+2611 BALLOT BOX WITH CHECK
    :?*:\ballotboldcheck\::🗹  ; U+1F5F9 BALLOT BOX WITH BOLD CHECK
    :?*:\square\::□           ; U+25A1 WHITE SQUARE
    :?*:\blacksquare\::■      ; U+25A0 BLACK SQUARE
    :?*:\triangle\::△         ; U+25B3 WHITE UP-POINTING TRIANGLE
    :?*:\dtriangle\::▽        ; U+25BD WHITE DOWN-POINTING TRIANGLE
    :?*:\ltriangle\::◃        ; U+25C3 WHITE LEFT-POINTING SMALL TRIANGLE
    :?*:\rtriangle\::▹        ; U+25B9 WHITE RIGHT-POINTING SMALL TRIANGLE

    ; subscript_superscript
    :?*:\sup0::⁰  ; U+2070 SUPERSCRIPT ZERO
    :?*:\sup1::¹  ; U+00B9 SUPERSCRIPT ONE
    :?*:\sup2::²  ; U+00B2 SUPERSCRIPT TWO
    :?*:\sup3::³  ; U+00B3 SUPERSCRIPT THREE
    :?*:\sup4::⁴  ; U+2074 SUPERSCRIPT FOUR
    :?*:\sup5::⁵  ; U+2075 SUPERSCRIPT FIVE
    :?*:\sup6::⁶  ; U+2076 SUPERSCRIPT SIX
    :?*:\sup7::⁷  ; U+2077 SUPERSCRIPT SEVEN
    :?*:\sup8::⁸  ; U+2078 SUPERSCRIPT EIGHT
    :?*:\sup9::⁹  ; U+2079 SUPERSCRIPT NINE
    :?*:\sup+::⁺  ; U+207A SUPERSCRIPT PLUS SIGN
    :?*:\sup-::⁻  ; U+207B SUPERSCRIPT MINUS
    :?*:\sup(::⁽  ; U+207D SUPERSCRIPT LEFT PARENTHESIS
    :?*:\sup)::⁾  ; U+207E SUPERSCRIPT RIGHT PARENTHESIS
    :?*:\sub0::₀  ; U+2080 SUBSCRIPT ZERO
    :?*:\sub1::₁  ; U+2081 SUBSCRIPT ONE
    :?*:\sub2::₂  ; U+2082 SUBSCRIPT TWO
    :?*:\sub3::₃  ; U+2083 SUBSCRIPT THREE
    :?*:\sub4::₄  ; U+2084 SUBSCRIPT FOUR
    :?*:\sub5::₅  ; U+2085 SUBSCRIPT FIVE
    :?*:\sub6::₆  ; U+2086 SUBSCRIPT SIX
    :?*:\sub7::₇  ; U+2087 SUBSCRIPT SEVEN
    :?*:\sub8::₈  ; U+2088 SUBSCRIPT EIGHT
    :?*:\sub9::₉  ; U+2089 SUBSCRIPT NINE
    :?*:\sub+::₊  ; U+208A SUBSCRIPT PLUS SIGN
    :?*:\sub-::₋  ; U+208B SUBSCRIPT MINUS
    :?*:\sub(::₍  ; U+208D SUBSCRIPT LEFT PARENTHESIS
    :?*:\sub)::₎  ; U+208E SUBSCRIPT RIGHT PARENTHESIS

    ; greek
    :?*C:\alpha\::α       ; U+03B1 GREEK SMALL LETTER ALPHA
    :?*C:\beta\::β        ; U+03B2 GREEK SMALL LETTER BETA
    :?*C:\gamma\::γ       ; U+03B3 GREEK SMALL LETTER GAMMA
    :?*C:\delta\::δ       ; U+03B4 GREEK SMALL LETTER DELTA
    :?*C:\epsilo\::ε      ; U+03B5 GREEK SMALL LETTER EPSILON
    :?*C:\zeta\::ζ        ; U+03B6 GREEK SMALL LETTER ZETA
    :?*C:\eta\::η         ; U+03B7 GREEK SMALL LETTER ETA
    :?*C:\theta\::θ       ; U+03B8 GREEK SMALL LETTER THETA
    :?*C:\iota\::ι        ; U+03B9 GREEK SMALL LETTER IOTA
    :?*C:\kappa\::κ       ; U+03BA GREEK SMALL LETTER KAPPA
    :?*C:\lambda\::λ      ; U+03BB GREEK SMALL LETTER LAMDA
    :?*C:\mu\::μ          ; U+03BC GREEK SMALL LETTER MU
    :?*C:\nu\::ν          ; U+03BD GREEK SMALL LETTER NU
    :?*C:\xi\::ξ          ; U+03BE GREEK SMALL LETTER XI
    :?*C:\omicron\::ο     ; U+03BF GREEK SMALL LETTER OMICRON
    :?*C:\pi\::π          ; U+03C0 GREEK SMALL LETTER PI
    :?*C:\rho\::ρ         ; U+03C1 GREEK SMALL LETTER RHO
    :?*C:\sigma\::σ       ; U+03C3 GREEK SMALL LETTER SIGMA
    :?*C:\tau\::τ         ; U+03C4 GREEK SMALL LETTER TAU
    :?*C:\upsilon\::υ     ; U+03C5 GREEK SMALL LETTER UPSILON
    :?*C:\phi\::φ         ; U+03C6 GREEK SMALL LETTER PHI
    :?*C:\chi\::χ         ; U+03C7 GREEK SMALL LETTER CHI
    :?*C:\psi\::ψ         ; U+03C8 GREEK SMALL LETTER PSI
    :?*C:\omega\::ω       ; U+03C9 GREEK SMALL LETTER OMEGA
    :?*C:\Alpha\::Α       ; U+0391 GREEK CAPITAL LETTER ALPHA
    :?*C:\Beta\::Β        ; U+0392 GREEK CAPITAL LETTER BETA
    :?*C:\Gamma\::Γ       ; U+0393 GREEK CAPITAL LETTER GAMMA
    :?*C:\Delta\::Δ       ; U+0394 GREEK CAPITAL LETTER DELTA
    :?*C:\Epsilo\::Ε      ; U+0395 GREEK CAPITAL LETTER EPSILON
    :?*C:\Zeta\::Ζ        ; U+0396 GREEK CAPITAL LETTER ZETA
    :?*C:\Eta\::Η         ; U+0397 GREEK CAPITAL LETTER ETA
    :?*C:\Theta\::Θ       ; U+0398 GREEK CAPITAL LETTER THETA
    :?*C:\Iota\::Ι        ; U+0399 GREEK CAPITAL LETTER IOTA
    :?*C:\Kappa\::Κ       ; U+039A GREEK CAPITAL LETTER KAPPA
    :?*C:\Lambda\::Λ      ; U+039B GREEK CAPITAL LETTER LAMDA
    :?*C:\Mu\::Μ          ; U+039C GREEK CAPITAL LETTER MU
    :?*C:\Nu\::N          ; U+004E LATIN CAPITAL LETTER N
    :?*C:\Xi\::X          ; U+0058 LATIN CAPITAL LETTER X
    :?*C:\Omicron\::Ο     ; U+039F GREEK CAPITAL LETTER OMICRON
    :?*C:\Pi\::Π          ; U+03A0 GREEK CAPITAL LETTER PI
    :?*C:\Rho\::Ρ         ; U+03A1 GREEK CAPITAL LETTER RHO
    :?*C:\Sigma\::Σ       ; U+03A3 GREEK CAPITAL LETTER SIGMA
    :?*C:\Tau\::Τ         ; U+03A4 GREEK CAPITAL LETTER TAU
    :?*C:\Upsilon\::Υ     ; U+03A5 GREEK CAPITAL LETTER UPSILON
    :?*C:\Phi\::Φ         ; U+03A6 GREEK CAPITAL LETTER PHI
    :?*C:\Chi\::Χ         ; U+03A7 GREEK CAPITAL LETTER CHI
    :?*C:\Psi\::Ψ         ; U+03A8 GREEK CAPITAL LETTER PSI
    :?*C:\Omega\::Ω       ; U+03A9 GREEK CAPITAL LETTER OMEGA
    :?*C:\varepsilon\::ε  ; U+03B5 GREEK SMALL LETTER EPSILON
    :?*C:\varkapa\::ϰ     ; U+03F0 GREEK KAPPA SYMBOL
    :?*C:\varphi\::φ      ; U+03C6 GREEK SMALL LETTER PHI
    :?*C:\varpi\::ϖ       ; U+03D6 GREEK PI SYMBOL
    :?*C:\varrho\::ϱ      ; U+03F1 GREEK RHO SYMBOL
    :?*C:\varsigma\::ς    ; U+03C2 GREEK SMALL LETTER FINAL SIGMA
    :?*C:\vartheta\::ϑ    ; U+03D1 GREEK THETA SYMBOL

    ; arrow
    :?*C:\uarr\::↑        ; U+2191 UPWARDS ARROW
    :?*C:\darr\::↓        ; U+2193 DOWNWARDS ARROW
    :?*C:\rarr\::→        ; U+2192 RIGHTWARDS ARROW
    :?*C:\larr\::←        ; U+2190 LEFTWARDS ARROW
    :?*C:\varr\::↕        ; U+2195 UP DOWN ARROW
    :?*C:\harr\::↔        ; U+2194 LEFT RIGHT ARROW
    :?*C:\Uarr\::⇑        ; U+21D1 UPWARDS DOUBLE ARROW
    :?*C:\Darr\::⇓        ; U+21D3 DOWNWARDS DOUBLE ARROW
    :?*C:\Rarr\::⇒        ; U+21D2 RIGHTWARDS DOUBLE ARROW
    :?*C:\Larr\::⇐        ; U+21D0 LEFTWARDS DOUBLE ARROW
    :?*C:\Varr\::⇕        ; U+21D5 UP DOWN DOUBLE ARROW
    :?*C:\Harr\::⇔        ; U+21D4 LEFT RIGHT DOUBLE ARROW
    :?*C:\dashrarr\::⇢    ; U+21E2 RIGHTWARDS DASHED ARROW
    :?*C:\dashlarr\::⇠    ; U+21E0 LEFTWARDS DASHED ARROW
    :?*C:\lrarr\::⇆       ; U+21C6 LEFTWARDS ARROW OVER RIGHTWARDS ARROW
    :?*C:\rlarr\::⇄       ; U+21C4 RIGHTWARDS ARROW OVER LEFTWARDS ARROW
    :?*C:\lrharpoons\::⇋  ; U+21CB LEFTWARDS HARPOON OVER RIGHTWARDS HARPOON
    :?*C:\rlharpoons\::⇌  ; U+21CC RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON
    :?*C:\nearr\::↗       ; U+2197 NORTH EAST ARROW
    :?*C:\nwarr\::↖       ; U+2196 NORTH WEST ARROW
    :?*C:\searr\::↘       ; U+2198 SOUTH EAST ARROW
    :?*C:\swarr\::↙       ; U+2199 SOUTH WEST ARROW
    :?*C:\ccwarr\::↺      ; U+21BA ANTICLOCKWISE OPEN CIRCLE ARROW
    :?*C:\cwarr\::↻       ; U+21BB CLOCKWISE OPEN CIRCLE ARROW

    ; latex
    :?*:\times\::×     ; U+00D7 MULTIPLICATION SIGN
    :?*:\pm\::±        ; U+00B1 PLUS-MINUS SIGN
    :?*:\neq\::≠       ; U+2260 NOT EQUAL TO
    :?*:\approx\::≈    ; U+2248 ALMOST EQUAL TO
    :?*:\approxeq\::≊  ; U+224A ALMOST EQUAL OR EQUAL TO
    :?*:\simeq\::≃     ; U+2243 ASYMPTOTICALLY EQUAL TO
    :?*:\cong\::≅      ; U+2245 APPROXIMATELY EQUAL TO
    :?*:\ge\::≥        ; U+2265 GREATER-THAN OR EQUAL TO
    :?*:\gt\::>        ; U+003E GREATER-THAN SIGN
    :?*:\gg\::≫        ; U+226B MUCH GREATER-THAN
    :?*:\le\::≤        ; U+2264 LESS-THAN OR EQUAL TO
    :?*:\lt\::<        ; U+003C LESS-THAN SIGN
    :?*:\ll\::≪        ; U+226A MUCH LESS-THAN
    :?*:\iif\::⟺       ; U+27FA LONG LEFT RIGHT DOUBLE ARROW
    :?*:\nabla\::∇     ; U+2207 NABLA
    :?*:\partial\::∂   ; U+2202 PARTIAL DIFFERENTIAL
    :?*:\ell\::ℓ       ; U+2113 SCRIPT SMALL L
    :?*:\sum\::∑       ; U+2211 N-ARY SUMMATION
    :?*:\prod\::∏      ; U+220F N-ARY PRODUCT
    :?*:\int\::∫       ; U+222B INTEGRAL
    :?*:\forall\::∀    ; U+2200 FOR ALL
    :?*:\exist\::∃     ; U+2203 THERE EXISTS
    :?*:\infin\::∞     ; U+221E INFINITY
    :?*:\propto\::∝    ; U+221D PROPORTIONAL TO
    :?*:\degree\::°    ; U+00B0 DEGREE SIGN
    :?*:\in\::∈        ; U+2208 ELEMENT OF
    :?*:\notin\::∉     ; U+2209 NOT AN ELEMENT OF
    :?*:\ni\::∋        ; U+220B CONTAINS AS MEMBER
    :?*:\cap\::∩       ; U+2229 INTERSECTION
    :?*:\cup\::∪       ; U+222A UNION
    :?*:\subset\::⊂    ; U+2282 SUBSET OF
    :?*:\subseteq\::⊆  ; U+2286 SUBSET OF OR EQUAL TO
    :?*:\supset\::⊃    ; U+2283 SUPERSET OF
    :?*:\supseteq\::⊇  ; U+2287 SUPERSET OF OR EQUAL TO
    :?*:\cdot\::⋅      ; U+22C5 DOT OPERATOR
    :?*:\ldots\::…     ; U+2026 HORIZONTAL ELLIPSIS
    :?*:\cdots\::⋯     ; U+22EF MIDLINE HORIZONTAL ELLIPSIS
    :?*:\vdots\::⋮     ; U+22EE VERTICAL ELLIPSIS
    :?*:\ddots\::⋱     ; U+22F1 DOWN RIGHT DIAGONAL ELLIPSIS
    :?*:\circ\::∘      ; U+2218 RING OPERATOR

    ; enclosed
    :?*:\c1\::①   ; U+2460 CIRCLED DIGIT ONE
    :?*:\c2\::②   ; U+2461 CIRCLED DIGIT TWO
    :?*:\c3\::③   ; U+2462 CIRCLED DIGIT THREE
    :?*:\c4\::④   ; U+2463 CIRCLED DIGIT FOUR
    :?*:\c5\::⑤   ; U+2464 CIRCLED DIGIT FIVE
    :?*:\c6\::⑥   ; U+2465 CIRCLED DIGIT SIX
    :?*:\c7\::⑦   ; U+2466 CIRCLED DIGIT SEVEN
    :?*:\c8\::⑧   ; U+2467 CIRCLED DIGIT EIGHT
    :?*:\c9\::⑨   ; U+2468 CIRCLED DIGIT NINE
    :?*:\c10\::⑩  ; U+2469 CIRCLED NUMBER TEN
    :?*:\c11\::⑪  ; U+246A CIRCLED NUMBER ELEVEN
    :?*:\c12\::⑫  ; U+246B CIRCLED NUMBER TWELVE
    :?*:\c13\::⑬  ; U+246C CIRCLED NUMBER THIRTEEN
    :?*:\c14\::⑭  ; U+246D CIRCLED NUMBER FOURTEEN
    :?*:\c15\::⑮  ; U+246E CIRCLED NUMBER FIFTEEN
    :?*:\c16\::⑯  ; U+246F CIRCLED NUMBER SIXTEEN
    :?*:\c17\::⑰  ; U+2470 CIRCLED NUMBER SEVENTEEN
    :?*:\c18\::⑱  ; U+2471 CIRCLED NUMBER EIGHTEEN
    :?*:\c19\::⑲  ; U+2472 CIRCLED NUMBER NINETEEN
    :?*:\c20\::⑳  ; U+2473 CIRCLED NUMBER TWENTY

    ; etc
    :?*:\shrug\::¯\_(ツ)_/¯

}

#HotIf wheel_down != 'None'
{
    WheelDown:: Send wheel_down
}
