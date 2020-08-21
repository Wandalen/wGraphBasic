require( 'wgraphbasic' );
let _ = wTools;

/*
This example shows how to create a simple graph.
Graph :: set of nodes( vertices ) and set of edges or arcs connecting some or all nodes.
*/

/*
Define a graph of arbitrary structure.
Strcuture of nodes is arbitrary. It could even be instance of a primitive type.
Group of nodes should have handlers which should return lists of neighbour nodes.
*/

var a = { name : 'a', nodes : [] }; // 1
var b = { name : 'b', nodes : [] }; // 2
var c = { name : 'c', nodes : [] }; // 3

// declare lists neighbour nodes

a.nodes.push( b ); // add edge between nodes a and b
b.nodes.push( c ); // add edge between nodes b and c

/* declare the graph */

var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
var group = sys.nodesGroup(); // declare group of nodes

console.log( group.nodesInfoExport([ a, b, c ]) ); // print information about nodes relation

/*
    1 : 2
    2 : 3
    3 :
*/
