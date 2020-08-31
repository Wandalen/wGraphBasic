
require( 'wgraphbasic' );
let _ = wTools;

/*
This example shows how to use breadth-first search on graph.
*/

/* define a graph of arbitrary structure */

var a = { name : 'a', nodes : [] }; // 1
var b = { name : 'b', nodes : [] }; // 2
var c = { name : 'c', nodes : [] }; // 3
var d = { name : 'd', nodes : [] }; // 4

a.nodes.push( b, c ); // add connections between node a and b, c nodes
c.nodes.push( d ); // add connection between node c and d

/* declare the graph */

var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
var group = sys.nodesGroup(); // declare group of nodes

/* breadth-first search for reachable nodes using provided node as start point */

var layers = group.lookBfs({ roots : a }); // node 'a' is start node
layers = layers.map( ( nodes ) => group.nodesToNames( nodes ) ) // extract name of nodes from node handles to simplify the output
console.log( layers )

/*
 [
   [ 'a' ],
   [ 'b', 'c' ],
   [ 'd' ]
]
*/
