# Version: 0.0.2
refreshFrequency: 1000
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
    iTunesvalues = output.split('~')
    
    if iTunesvalues[3] == 'playing'
        $(domEl).find("#iTunesPlay").hide()
        $(domEl).find("#iTunesPause").show()
    else
        $(domEl).find("#iTunesPause").hide()
        $(domEl).find("#iTunesPlay").show()
    
    if $(domEl).find('#iTunesTitle').text() == iTunesvalues[0]
        return
        
    $(domEl).find('#iTunesArtist').text("#{iTunesvalues[1]}")
    $(domEl).find('#iTunesTitle').text("#{iTunesvalues[0]}")
        
    if iTunesvalues[0] != " " && iTunesvalues[1] != " "
        html = "<img src='iTunesMiniPlayer.widget/images/albumart.jpg'>"
        $(domEl).find('#cover').html("")
        $(domEl).find('#cover').html(html)
    else
        $(domEl).find('#cover').html("")