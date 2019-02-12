require( '..' );
let _ = wTools;

/*
This example shows how to create simplest graph
Graph :: set of nodes( vertices ) and set of edges or arcs connecting some or all nodes.
*/

// nodes declaration

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3

// Neigbour nodes declaration

a.nodes.push( b ); // add edge between nodes a and b
b.nodes.push( c ); // add edge between nodes b and c

// making a graph

var sys = new _.graph.AbstractGraphSystem(); // make container for groups( graphs )
var group = sys.groupMake(); // create graph( empty group of nodes )
group.nodesAdd([ a,b,c ]); // add nodes to the group

console.log( group.nodesExportInfo() ); // print information about nodes relation
/*
    1 : 2
    2 : 3
    3 :
*/