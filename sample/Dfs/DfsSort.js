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

/* depth first topological sort */

var ordering = group.topologicalSortDfs(); // arrange nodes so that for each connection "uv" node "u" comes before "v"
ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
console.log( ordering );

/* [ 'b', 'd', 'c', 'a' ] */











