## Option allSiblings

An option that controls the ability to re-visit a node if it has sibling nodes.

![DfsAllSiblings0.png](../../images/searchOptions/DfsAllSiblings0.png)

If `allSiblings : 0`, then routine does not change the traversal of graph.

![DfsAllSiblings1.png](../../images/searchOptions/DfsAllSiblings1.png)

If `allSiblings : 1`, then routine re-visit sibling node and does not traverse next nodes if option `revisiting <= 1`.

![DfsAllSiblings1.png](../../images/searchOptions/DfsAllSiblings1.png)

If `allSiblings : 2`, then routine re-visit sibling node and makes traversal of next nodes even if option `revisiting <= 1`.
