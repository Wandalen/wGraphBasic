# Option revisiting

An option that controls the ability to re-visit a node with multiple input edges.

 ![DfsRevisiting0.png](../images/DfsRevisiting0.png)

 If `revisiting : 0`, then routine visits each node only once.

 ![DfsRevisiting1.png](../images/DfsRevisiting1.png)

 If `revisiting : 1`, then routine can visits nodes with a few input edges twice.

 ![DfsRevisiting2.png](../images/DfsRevisiting2.png)

 If `revisiting : 2`, then routine visits nodes, which connects by two direction edges.

 ![DfsRevisiting3.png](../images/DfsRevisiting3.png)

 If `revisiting : 3`, then routine use stack to make queue of nodes and has no limit for visiting of nodes. So, if graph has cycled connection of nodes, routine needs additional condition for exit from loop.
