# LearnLite
E-learning compatible with limited internet access

When using the ppp.jl html generator operations are triggered with a new line, for example if a line starts with http it will be transformed into a link. To avoid this simply add a space, otherwise "http.createServer((req, res) => {" gets transformed into a link with text "res) => {". <, > and & are escaped by spacing the "opside", ie 123& 456 turns into 123&456 and < tag > turns into &lt;tag&gt;. Run the ppp like so: julia ppp.jl happiness

The project is hosted here: https://jhlq.github.io/LearnLite/html/
