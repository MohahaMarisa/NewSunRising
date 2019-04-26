// ZIP CODE ARRAY
int[][] zipcodeGrid = 
{{15202, 15212, 15212, 15214, 15209, 15223, 15201, 15206, 15206},
{15136, 15212, 15212, 15214, 15212, 15201, 15201, 15206, 15206},
{15204, 15204, 15233, 15212, 15212, 15201, 15224, 15232, 15208},
{15205, 15220, 15220, 15222, 15219, 15213, 15213, 15217, 15217},
{15205, 15205, 15220, 15211, 15203, 15203, 15207, 15207, 15221},
{15205, 15205, 15216, 15226, 15210, 15210, 15207, 15207, 15120}};

// NEARBY ZIP CODES (5 Mile Radius)
int[][] nearbyZipcodes5 = {
{15209, 15214, 15202, 15223}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15209, 15202, 15223}, {15209, 15202, 15223}, {15201, 15224}, {15208, 15206}, {15208, 15206}, 
{15136}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15212, 15214, 15222}, {15201, 15224}, {15201, 15224}, {15208, 15206}, {15208, 15206}, {15233, 15233, 15204, 15205}, 
{15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205, 15220}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15201, 15224}, {15232, 15201, 15224, 15213}, {15232, 15207, 15224, 15213, 15217}, 
{15208, 15206, 15217}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, {15216, 15233, 15233, 15220, 15211}, {15212, 15222}, {15221, 15219}, {15232, 15224, 15213, 15203}, 
{15232, 15224, 15213, 15203}, {15232, 15208, 15207, 15217}, {15232, 15208, 15207, 15217}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, 
{15216, 15220, 15211, 15226}, {15210, 15213, 15203}, {15210, 15213, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15221, 15219}, {15233, 15233, 15204, 15205}, 
{15233, 15233, 15204, 15205}, {15216, 15220, 15211, 15226}, {15216, 15211, 15226}, {15210, 15203}, {15210, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15207, 15120, 15218}};

// NEARBY ZIP CODES (10 Mile Radius)
int[][] nearbyZipcodes10 = 
{{15209, 15214, 15202, 15223}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15209, 15202, 15223}, {15209, 15202, 15223}, {15201, 15224}, {15208, 15206}, {15208, 15206}, {15136}, 
{15212, 15214, 15222}, {15212, 15214, 15222}, {15212, 15214, 15202}, {15212, 15214, 15222}, {15201, 15224}, {15201, 15224}, {15208, 15206}, {15208, 15206}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, 
{15233, 15233, 15204, 15205, 15220}, {15212, 15214, 15222}, {15212, 15214, 15222}, {15201, 15224}, {15232, 15201, 15224, 15213}, {15232, 15207, 15224, 15213, 15217}, {15208, 15206, 15217}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, {15216, 15233, 15233, 15220, 15211}, {15212, 15222}, {15221, 15219}, {15232, 15224, 15213, 15203}, {15232, 15224, 15213, 15203}, {15232, 15208, 15207, 15217}, {15232, 15208, 15207, 15217}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, {15216, 15233, 15233, 15220, 15211}, {15216, 15220, 15211, 15226}, {15210, 15213, 15203}, {15210, 15213, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15221, 15219}, {15233, 15233, 15204, 15205}, {15233, 15233, 15204, 15205}, {15216, 15220, 15211, 15226}, {15216, 15211, 15226}, {15210, 15203}, {15210, 15203}, {15232, 15207, 15120, 15217}, {15232, 15207, 15120, 15217}, {15207, 15120, 15218}, {15209, 15201, 15212, 15224, 15214, 15222, 15202, 15229, 15223}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233}, {15209, 15201, 15212, 15224, 15214, 15202, 15229, 15223}, {15209, 15201, 15212, 15206, 15224, 15214, 15213, 15215, 15202, 15223}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15136, 15229, 15228, 15233, 15233, 15204, 15205}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15232, 15208, 15221, 15207, 15201, 15206, 15224, 15219, 15213, 15215, 15217, 15223, 15218}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211, 15226}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211, 15226}, {15212, 15136, 15214, 15222, 15216, 15229, 15233, 15233, 15204, 15205, 15220, 15211, 15226}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15209, 15201, 15212, 15224, 15214, 15222, 15213, 15202, 15229, 15223, 15233, 15233, 15203, 15220, 15211}, {15232, 15208, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15215, 15202, 15217, 15223, 15203}, {15210, 15232, 15208, 15207, 15209, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15202, 15217, 15223, 15203}, {15210, 15232, 15208, 15207, 15201, 15120, 15206, 15224, 15222, 15213, 15217, 15218, 15203}, {15232, 15208, 15221, 15207, 15201, 15120, 15206, 15224, 15219, 15213, 15215, 15217, 15218}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15212, 15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15212, 15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15232, 15201, 15212, 15224, 15214, 15222, 15213, 15216, 15202, 15233, 15233, 15203, 15220, 15211, 15226}, {15208, 15221, 15104, 15206, 15219, 15217, 15218}, {15210, 15232, 15208, 15207, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15217, 15223, 15203, 15211}, {15210, 15232, 15208, 15207, 15201, 15212, 15206, 15224, 15214, 15222, 15213, 15217, 15223, 15203, 15211}, {15210, 15232, 15208, 15207, 15201, 15120, 15206, 15224, 15219, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15201, 15120, 15206, 15224, 15219, 15213, 15217, 15218, 15203}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15212, 15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15212, 15222, 15213, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15232, 15207, 15201, 15212, 15224, 15222, 15213, 15216, 15217, 15203, 15220, 15211, 15226}, {15210, 15232, 15207, 15201, 15212, 15224, 15222, 15213, 15216, 15217, 15203, 15220, 15211, 15226}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15208, 15221, 15104, 15206, 15219, 15218}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15136, 15216, 15233, 15233, 15204, 15205, 15220, 15211}, {15222, 15216, 15233, 15233, 15203, 15204, 15205, 15220, 15211, 15226}, {15210, 15222, 15216, 15233, 15233, 15203, 15204, 15220, 15211, 15226}, {15210, 15232, 15207, 15120, 15224, 15222, 15213, 15217, 15203, 15211, 15226}, {15210, 15232, 15207, 15120, 15224, 15222, 15213, 15217, 15203, 15211, 15226}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15120, 15206, 15224, 15213, 15217, 15218, 15203}, {15210, 15232, 15208, 15207, 15104, 15120, 15217, 15218}};


// LAT LONGS
//{15232: {40.461947, -79.915167}, 15104: {40.416888, -79.83783509999999}, 15235: {40.5502739, -79.776787}, 15237: {40.5946901, -79.986975}, 15233: {40.478524, -80.01341289999999}, 15120: {40.417056, -79.8777719}, 15001: {40.6658329, -80.22868}, 15132: {40.364992, -79.8082791}, 15136: {40.5169811, -80.0468411}, 15201: {40.49156989999999, -79.93112310000001}, 15202: {40.521929, -79.951013}, 15203: {40.437697, -79.951683}, 15204: {40.4656758, -80.0375679}, 15205: {40.470715, -80.043431}, 15206: {40.4927379, -79.883772}, 15207: {40.4362111, -79.89945}, 15208: {40.4646109, -79.883239}, 15209: {40.5287469, -79.951054}, 15210: {40.425946, -79.9381559}, 15019: {40.477568, -80.285159}, 15212: {40.494734, -79.9724021}, 15213: {40.46063700000001, -79.93719}, 15214: {40.507202, -79.9737799}, 15215: {40.526597, -79.8834789}, 15216: {40.430076, -80.010481}, 15217: {40.4499356, -79.8986718}, 15218: {40.436855, -79.86769}, 15219: {40.472077, -79.840588}, 15220: {40.4525859, -80.007819}, 15221: {40.463628, -79.8346261}, 15222: {40.46445689999999, -79.9731011}, 15223: {40.5220399, -79.9380121}, 15224: {40.478645, -79.93278699999999}, 15226: {40.4221701, -79.9981669}, 15229: {40.535651, -80.00370889999999}, 15228: {40.5532377, -80.0184329}, 15146: {40.462069, -79.6985371}, 15211: {40.444485, -79.9972109}}
