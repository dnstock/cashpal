/*
Please refer to readme.html for full Instructions

Text[...]=[title,text]

Style[...]=[ 0 TitleColor,
             1 TextColor,
             2 TitleBgColor,
             3 TextBgColor,
             4 TitleBgImag,       # Depricated.
             5 TextBgImag,        # Depricated.
             6 TitleTextAlign,
             7 TextTextAlign,
             8 TitleFontFace,
             9 TextFontFace,
            10 TipPosition,
            11 StickyStyle,
            12 TitleFontSize,
            13 TextFontSize,
            14 Width,
            15 Height,
            16 BorderSize,
            17 PadTextArea,
            18 CoordinateX,
            19 CoordinateY,
            20 TransitionNumber,
            21 TransitionDuration,
            22 TransparencyLevel,
            23 ShadowType,
            24 ShadowColor ]
*/

var FiltersEnabled = 0 // if your not going to use transitions or filters in any of the tips set this to 0

Text[0]=["Pending","Amount reported, but waiting the required 90-120 days until you can cash out."]
Text[1]=["Available","Amount you can cash out at any time."]
Text[2]=["Requested","Amount you have requested to have paid to you, but that has not yet been sent."]
Text[3]=["Cashed Out","Amount of Cash Back withdrawals you have made to date."]
Text[4]=["Lifetime Cash Back","Running total of all Cash Back you have earned."]

Style[0]=["white","#447505","#7BAF36","#DCFFAF","","","","","","","","","10px","10px","","","2px","2px",20,10,"","","","",""]
Style[1]=["white","#447505","#7BAF36","#DCFFAF","","","","","","","","","10px","10px","130px","","2px","2px",15,10,"","","","",""]
// Style=[   0   ,    1    ,    2    ,    3    , 4, 5, 6, 7, 8, 9,10,11,  12  ,  13  ,14,15,  16 ,  17 ,18,19,20,21,22,23,24]

applyCssFilter()

