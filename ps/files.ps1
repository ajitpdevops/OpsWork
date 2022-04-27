

(gci -Name "propertybardecisionsandoverridespace.MYD", "propertybardecisionsandoverridespace.MYI", "propertybardecisionsandoverridespace.frm" | measure Length -s).Sum )
foreach-object { "{0:N2}" -f ((gci "propertybardecisionsandoverridespace.MYD", "propertybardecisionsandoverridespace.MYI", "propertybardecisionsandoverridespace.frm" | Measure-Object Length -s).SUM /1mb) }
