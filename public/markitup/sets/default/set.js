// ----------------------------------------------------------------------------
// markItUp!
// ----------------------------------------------------------------------------
// Copyright (C) 2008 Jay Salvat
// http://markitup.jaysalvat.com/
// ----------------------------------------------------------------------------
myMarkdownSettings = {
    nameSpace:          'markdown', // Useful to prevent multi-instances CSS conflict
    previewParserPath:  '~/sets/markdown/preview.php',
    onShiftEnter:       {keepDefault:false, openWith:'\n\n'},
    markupSet: [
        {name:'Bold', key:"B", openWith:'**', closeWith:'**'},
        {name:'Italic', key:"I", openWith:'_', closeWith:'_'},
        {separator:'---------------' },
        {name:'Bulleted List', openWith:'- ' },
        {name:'Numeric List', openWith:function(markItUp) {
            return markItUp.line+'. ';
        }},
        {separator:'---------------' },
        {name:'Link', key:"L", openWith:'[', closeWith:']([![Url:!:http://]!] "[![Title]!]")', placeHolder:'Your text to link here...' },
        {separator:'---------------'},    
        {name:'Quotes', openWith:'> '},
        {name:'Code Block / Code', openWith:'(!(\t|!|`)!)', closeWith:'(!(`)!)'},
    ]
}

// mIu nameSpace to avoid conflict.
miu = {
    markdownTitle: function(markItUp, char) {
        heading = '';
        n = $.trim(markItUp.selection||markItUp.placeHolder).length;
        for(i = 0; i < n; i++) {
            heading += char;
        }
        return '\n'+heading+'\n';
    }
}