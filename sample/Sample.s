
require( 'wgraphbasic' );
let _ = wTools;

/*
This example shows basics.
Graph :: set of nodes( vertices ) and set of edges or arcs connecting some or all nodes.
*/

/* define a graph of arbitrary structure */

var a = { name : 'a', nodes : [] }; // 1
var b = { name : 'b', nodes : [] }; // 2
var c = { name : 'c', nodes : [] }; // 3
var d = { name : 'd', nodes : [] }; // 4
var e = { name : 'e', nodes : [] }; // 5
var f = { name : 'f', nodes : [] }; // 6
var g = { name : 'g', nodes : [] }; // 7
var h = { name : 'h', nodes : [] }; // 8
var i = { name : 'i', nodes : [] }; // 9
var j = { name : 'j', nodes : [] }; // 10

a.nodes.push( b );    // 1
b.nodes.push( e, f ); // 2
c.nodes.push( b );    // 3
d.nodes.push( a, g ); // 4
e.nodes.push( a, c, h ); // 5
f.nodes.push();       // 6
g.nodes.push( h );    // 7
h.nodes.push( i );    // 8
i.nodes.push( f, h ); // 9
j.nodes.push();       // 10

/* declare the graph */

var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
var group = sys.nodesGroup(); // declare group of nodes

// print nodes lists

console.log( group.nodesInfoExport([ a, b, c, d, e, f, g, h, i, j ]) );

// do topological sort

var layers = group.topSortLeastDegreeBfs([ a, b, c, d, e, f, g, h, i, j ]);
console.log( layers.map( ( nodes ) => group.nodesToNames( nodes ) ) );

/*
[
  [ 'd', 'j' ],
  [ 'a', 'g' ],
  [ 'b', 'h' ],
  [ 'e', 'f', 'i' ],
  [ 'c' ]
];
*/
