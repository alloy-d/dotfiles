// Vimperator plugin: 'Read Later'
//
// place in ~/.vimperator/plugin/readlater.js
// pushing ,rl will send the url to the 'readlater' script

mappings.addUserMap([modes.NORMAL], [",rl"],
        "Read later",
        function () {
                var u = escape(document.getElementById("urlbar").value);
                var r = io.system("readlater --escaped '" + u + "'");
                liberator.echo("readlater returned " + r);
        });


// vim: set fdm=marker sw=4 ts=4 et:
