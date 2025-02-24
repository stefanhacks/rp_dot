extends Node

var Popups = {
	'STRIKE': 'Confirm strike?',
}

var Card = {
	'MOVE': { 'TITLE': 'MOVE', 'DESCRIPTION': 'Step over x free squares.'},
	'STRIKE': { 'TITLE': 'STRIKE', 'DESCRIPTION': 'Strike target for x damage.'},
	'BREATHE': { 'TITLE': 'BREATHE', 'DESCRIPTION': 'Recover x health. Once.'},
}


var Themes = {
	'MOVE': { 'BG': Color(0.253, 0.597, 0.501), 'BORDER': Color(0.063, 0.506, 0.439) },
	'STRIKE': { 'BG': Color(0.914, 0.381, 0.316), 'BORDER': Color(0.642, 0.269, 0.252) },
	'BREATHE': { 'BG': Color(0.168, 0.401, 0.603), 'BORDER': Color(0.071, 0.21, 0.332) },
}
