# LearnLite
E-learning compatible with limited internet access

When using the ppp.jl html generator operations are triggered with a new line, for example if a line starts with http it will be transformed into a link. To avoid this simply add a space, otherwise "http.createServer((req, res) => {" gets transformed into a link with text "res) => {". <, > and & are automatically parsed if the "opside" is free, ie 123& 456 turns into 123&456 and < tag > turns into <tag> 
