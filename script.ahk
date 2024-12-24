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
        Send FormatTime(, "yyyy-MM-dd")
    }
    :?*:\now\::
    {
        Send FormatTime(, "yyyy-MM-dd HH:mm:ss")
    }
}

#HotIf hotstrings
{
    ; general
    :?*:\degc\::℃
    :?*:\endash\::–
    :?*:\emdash\::—
    :?*:\cdot\::⋅
    :?*:\dots\::…
    :?*:\cdots\::⋯
    :?*:\vdots\::⋮
    :?*:\bullet\::∙
    :?*:\circ\::∘
    :?*:\check\::✓
    :?*:\heavycheck\::✔
    :?*:\heavymul\::✖
    :?*:\product\::⨯
    :?*:\ballotbox\::☐
    :?*:\ballotcheck\::☑
    :?*:\ballotboldcheck\::🗹
    :?*:\square\::□
    :?*:\blacksquare\::■
    :?*:\triangle\::△
    :?*:\dtriangle\::▽
    :?*:\ltriangle\::◃
    :?*:\rtriangle\::▹

    ; subscript_superscript
    :?*:\sup0::⁰
    :?*:\sup1::¹
    :?*:\sup2::²
    :?*:\sup3::³
    :?*:\sup4::⁴
    :?*:\sup5::⁵
    :?*:\sup6::⁶
    :?*:\sup7::⁷
    :?*:\sup8::⁸
    :?*:\sup9::⁹
    :?*:\sup+::⁺
    :?*:\sup-::⁻
    :?*:\sup(::⁽
    :?*:\sup)::⁾
    :?*:\sub0::⁰
    :?*:\sub1::₁
    :?*:\sub2::₂
    :?*:\sub3::₃
    :?*:\sub4::₄
    :?*:\sub5::₅
    :?*:\sub6::₆
    :?*:\sub7::₇
    :?*:\sub8::₈
    :?*:\sub9::₉
    :?*:\sub+::₊
    :?*:\sub-::₋
    :?*:\sub(::₍
    :?*:\sub)::₎

    ; greek
    :?*C:\alpha\::α
    :?*C:\beta\::β
    :?*C:\gamma\::γ
    :?*C:\delta\::δ
    :?*C:\epsilo\::ε
    :?*C:\zeta\::ζ
    :?*C:\eta\::η
    :?*C:\theta\::θ
    :?*C:\iota\::ι
    :?*C:\kappa\::κ
    :?*C:\lambda\::λ
    :?*C:\mu\::μ
    :?*C:\nu\::ν
    :?*C:\xi\::ξ
    :?*C:\omicron\::ο
    :?*C:\pi\::π
    :?*C:\rho\::ρ
    :?*C:\sigma\::σ
    :?*C:\tau\::τ
    :?*C:\upsilon\::υ
    :?*C:\phi\::φ
    :?*C:\chi\::χ
    :?*C:\psi\::ψ
    :?*C:\omega\::ω
    :?*C:\Alpha\::Α
    :?*C:\Beta\::Β
    :?*C:\Gamma\::Γ
    :?*C:\Delta\::Δ
    :?*C:\Epsilo\::Ε
    :?*C:\Zeta\::Ζ
    :?*C:\Eta\::Η
    :?*C:\Theta\::Θ
    :?*C:\Iota\::Ι
    :?*C:\Kappa\::Κ
    :?*C:\Lambda\::Λ
    :?*C:\Mu\::Μ
    :?*C:\Nu\::N
    :?*C:\Xi\::X
    :?*C:\Omicron\::Ο
    :?*C:\Pi\::Π
    :?*C:\Rho\::Ρ
    :?*C:\Sigma\::Σ
    :?*C:\Tau\::Τ
    :?*C:\Upsilon\::Υ
    :?*C:\Phi\::Φ
    :?*C:\Chi\::Χ
    :?*C:\Psi\::Ψ
    :?*C:\Omega\::Ω
    :?*C:\varepsilon\::ε
    :?*C:\varkapa\::ϰ
    :?*C:\varphi\::φ
    :?*C:\varpi\::ϖ
    :?*C:\varrho\::ϱ
    :?*C:\varsigma\::ς
    :?*C:\vartheta\::ϑ

    ; arrow
    :?*C:\uarr\::↑
    :?*C:\darr\::↓
    :?*C:\rarr\::→
    :?*C:\larr\::←
    :?*C:\varr\::↕
    :?*C:\harr\::↔
    :?*C:\Uarr\::⇑
    :?*C:\Darr\::⇓
    :?*C:\Rarr\::⇒
    :?*C:\Larr\::⇐
    :?*C:\Varr\::⇕
    :?*C:\Harr\::⇔
    :?*C:\dashrarr\::⇢
    :?*C:\dashlarr\::⇠
    :?*C:\lrarr\::⇆
    :?*C:\rlarr\::⇄
    :?*C:\lrharpoons\::⇋
    :?*C:\rlharpoons\::⇌
    :?*C:\nearr\::↗
    :?*C:\nwarr\::↖
    :?*C:\searr\::↘
    :?*C:\swarr\::↙
    :?*C:\ccwarr\::↺
    :?*C:\cwarr\::↻

    ; latex
    :?*:\times\::×
    :?*:\pm\::±
    :?*:\neq\::≠
    :?*:\approx\::≈
    :?*:\approxeq\::≊
    :?*:\simeq\::≃
    :?*:\ge\::≥
    :?*:\gt\::>
    :?*:\gg\::≫
    :?*:\le\::≤
    :?*:\lt\::<
    :?*:\ll\::≪
    :?*:\iif\::⟺
    :?*:\nabla\::∇
    :?*:\partial\::∂
    :?*:\ell\::ℓ
    :?*:\sum\::∑
    :?*:\prod\::∏
    :?*:\int\::∫
    :?*:\forall\::∀
    :?*:\exist\::∃
    :?*:\infin\::∞
    :?*:\propto\::∝
    :?*:\degree\::°
    :?*:\in\::∈
    :?*:\notin\::∉
    :?*:\ni\::∋
    :?*:\cap\::∩
    :?*:\cup\::∪
    :?*:\subset\::⊂
    :?*:\subseteq\::⊆
    :?*:\supset\::⊃
    :?*:\supseteq\::⊇
}

#HotIf wheel_down != 'None'
{
    WheelDown:: Send wheel_down
}
