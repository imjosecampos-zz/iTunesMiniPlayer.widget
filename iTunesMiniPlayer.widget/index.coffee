# Version: 0.83a
## If you do not want a transparent widget, please adjust the opacity setting under STYLE
## If you do not know how to write HTML/CSS, it is best for you to learn it first before
## attempting to customise the UI. Or you can contact me.
## Any advise or new idea is welcome. Do not hesitate to contact me, my email is: jetic@me.com
# Refreshing Frequency is set to once every 1000ms
refreshFrequency: 1000
# Information on cells
## Cells consists of three parts. A main body(nav), a top and a bottom(s and b). Cells are rotated
## 90 degrees to the current position. For special cells (Battery cell, iTunes cell), the toppings
## and bottoms are slightly different, for example s1, s2, b1, b2, these are modified to cover
## the gaps between the originally seperated cells. Almost all the elements in the cells are
## positioned manually, this is to ensure that the UI looks exactly the same on different
## environments. Übersicht is using the safari engine to render the widgets, therefore the UI under
## different versions of Safari could be different, if so please contact me and I'll fix this. There
## are also classes like a0, a1, a2, a3, a4, these act as collective cell controlls allowing me to
## change the output of all related cells when necessary. ai cells are initially hidden; a1 and a2
## are used to adjust the lines so that the cells won't crash into each other; a3 is the battery
## cell; a4 is the console output cell; ax hasn't been used. Contents in the cells can use the
## classes content of bigger text or contents for smaller text, although most of the time it might
## be better to adjust the font-size manually. It is obvious that some of the cells are hidden(ai),
## these can be easily modified to display new contents as you like. I will personally add more to
## this widget as well. Please look out for my updates and if you've done something amazing with
## your copy of this widget and want me to add, please contact me.
##
style: """
    position:absolute
    margin:0px
    top: 15px
    left: 15px
    width:200px
    border: 1px solid #FFF;
    color:#FFF
    min-height: 54px
    
    #cover
        display:block
        width: 200px
        height: 200px
    #cover img
        width: 200px
        height: 200px
    #content
        background: rgba(#000, .5)
        position: absolute
        padding: 10px 0
        bottom: 0
        width: 100%
        height: 72px
        text-align:center
        overflow:hidden
    #content p
        width:1000px
        left: 50%;
        position: relative
        font-family: Helvetica Neue
        font-size: 12px
        line-height: 20px
        margin:0 0 10px -500px
        padding:0
    #iTunesPre
        display: inline-block
        margin-right:15px
    #iTunesPre span
        display: inline-block
        width: 0
        height: 0
        border-top: 10px solid transparent
        border-right: 20px solid white
        border-bottom: 10px solid transparent
    #iTunesNext
        display: inline-block
    #iTunesNext span
        display: inline-block
        width: 0
        height: 0
        border-top: 10px solid transparent
        border-left: 20px solid white
        border-bottom: 10px solid transparent
    #iTunesPause
        display: inline-block
        margin-right:10px
    #iTunesPause span
        display: inline-block
        height:20px
        width:8px
        display: inline-block
        background:#FFF
        margin-right: 5px
    #iTunesPlay
        margin-right:15px
        display: inline-block
        width: 0
        height: 0
        border-top: 10px solid transparent
        border-left: 20px solid white
        border-bottom: 10px solid transparent
"""

render: -> """
    <div id="cover"></div>
    <div id="content">
        <p><span id="iTunesArtist"></span></br><span id="iTunesTitle"></span></p>
        <div id="iTunesPre"><span></span><span></span></div>
        <div id="iTunesPause"><span></span><span></span></div>
        <div id="iTunesPlay"></div>
        <div id="iTunesNext"><span></span><span></span></div>
    </div>
"""

command:    "osascript 'iTunesMiniPlayer.widget/iTunes.scpt'"

afterRender: (domEl) ->
    $(domEl).on 'click', '#iTunesPre', => @run "osascript -e 'tell application \"iTunes\" to previous track'"
    $(domEl).on 'click', '#iTunesNext', => @run "osascript -e 'tell application \"iTunes\" to next track'"
    $(domEl).on 'click', '#iTunesPause', => @run "osascript -e 'tell application \"iTunes\" to pause'"
    $(domEl).on 'click', '#iTunesPlay', => @run "osascript -e 'tell application \"iTunes\" to play'"

update: (output, domEl) ->
    iTunesvalues    = output.split('~')
    update     = false
    
    #console.log output
    
    if $(domEl).find('#iTunesTitle').text() == iTunesvalues[0]
        return
        
    $(domEl).find('#iTunesArtist').text("#{iTunesvalues[1]}")
    $(domEl).find('#iTunesTitle').text("#{iTunesvalues[0]}")
    
    if iTunesvalues[3] == 'playing'
        $(domEl).find("#iTunesPlay").hide()
        $(domEl).find("#iTunesPause").show()
    else
        $(domEl).find("#iTunesPause").hide()
        $(domEl).find("#iTunesPlay").show()
        
    if iTunesvalues[0] != " " && iTunesvalues[1] != " "
        html = "<img src='iTunesMiniPlayer.widget/images/albumart.jpg'>"
        $(domEl).find('#cover').html("")
        $(domEl).find('#cover').html(html)
    else
        $(domEl).find('#cover').html("")