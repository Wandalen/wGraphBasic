require( '../..' );
let _ = wTools;

/* This example shows how to use dfs-based algorimths on directed acycled graph(DAG) */

/* declaring nodes and relations */

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3
var d = { name : 'd', nodes : [] } // 4

a.nodes.push( b,c );
c.nodes.push( d );

/* making a graph */

var sys = new _.graph.AbstractGraphSystem(); // make container for groups( graphs )
var group = sys.groupMake(); // create graph( empty group of nodes )
group.nodesAdd([ a,b,c,d ]); // add nodes to the group

/* checking if nodes are connected using dfs algorithm */

var connected = group.nodesAreConnectedDfs( a, d );
console.log( 'Nodes a and d are connected:', connected )

var connected = group.nodesAreConnectedDfs( b, d );
console.log( 'Nodes b and d are connected:', connected )

/* group connected nodes */

c.nodes = []; // break connection between c and d nodes
d.nodes.push( c ); // connect d and c nodes to make second group
var connectedNodes = group.groupByConnectivityDfs();
console.log( 'Nodes grouped by connectivity:', connectedNodes )

/*
[
    a  b  c      d  c
  [ 1, 2, 3 ], [ 4, 3 ]
] */










