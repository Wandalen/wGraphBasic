require( 'wgraphbasic' );
let _ = wTools;

/*
This example shows how to check connectivity betwen two nodes.
Algorithm is based on deapth first search.
*/

/* define a graph of arbitrary structure */

var a = { name : 'a', nodes : [] }; // 1
var b = { name : 'b', nodes : [] }; // 2
var c = { name : 'c', nodes : [] }; // 3
var d = { name : 'd', nodes : [] }; // 4

a.nodes.push( b, c );
c.nodes.push( d );

/* declare the graph */

var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
var group = sys.nodesGroup(); // declare group of nodes

/* checking if nodes are connected using dfs algorithm */

var connected = group.pairDirectedPathGetDfs([ a, d ]);
console.log( 'Nodes a and d are connected:', connected )

var connected = group.pairDirectedPathGetDfs([ b, d ]);
console.log( 'Nodes b and d are connected:', connected )

/* group connected nodes */

c.nodes = []; // break connection between c and d nodes
d.nodes.push( c ); // connect d and c nodes to make second group
var connectedNodes = group.nodesConnectedLayersDfs([ a, b, c, d ]);
console.log( 'Nodes grouped by connectivity:', connectedNodes )

/*
[
    a  b  c      d
  [ 1, 2, 3 ], [ 4 ]
] */
