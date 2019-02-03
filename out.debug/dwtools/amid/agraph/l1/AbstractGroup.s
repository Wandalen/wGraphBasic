( function _AbstractGroup_s_( ) {

'use strict';

let _ = _global_.wTools;
let Parent = null;
let Self = function wAbstractGraphGroup( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'AbstractGraphGroup';

// --
// routine
// --

function init( o )
{
  let group = this;

  group[ nodesSymbol ] = [];
  // group[ directSymbol ] = true;

  _.instanceInit( group );
  Object.preventExtensions( group );

  if( o )
  group.copy( o );

  group.form();

  return group;
}

//

function finit()
{
  let group = this;
  group.unform();
  _.Copyable.prototype.finit.call( group );
}

//

function form()
{
  let group = this;
  _.assert( group.sys instanceof _.AbstractGraphSystem );
  _.arrayAppendOnceStrictly( group.sys.groups, group );
}

//

function unform()
{
  let group = this;
  group.nodesDelete();
  _.arrayRemoveOnceStrictly( group.sys.groups, group );
}

//

function clone()
{
  let group = this;
  let group2 = _.Copyable.prototype.clone.apply( group, arguments );
  return group2;
}

// --
// reverse
// --

function directSet( val )
{
  let group = this;
  let nodes = group.nodes;

  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( val ) );

  val = !!val;

  if( group[ directSymbol ] === undefined )
  {
    group[ directSymbol ] = val;
    return val;
  }

  group.reverse( val );

  return val;
}

//

function reverse( val )
{
  let group = this;
  let nodes = group.nodes;

  if( val === undefined )
  val = !group.direct;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( group.direct === val )
  return group;

  if( !val && !group.onReverseNeighbourNodesGet )
  {
    group.onReverseNeighbourNodesGet = group.cahcedOnReverseNeighbourNodesGet;
    group.cacheReverseFromDirectNeigbourNodes();
  }

  let onDirectNeighbourNodesGet = group.onDirectNeighbourNodesGet;
  let onReverseNeighbourNodesGet = group.onReverseNeighbourNodesGet;

  _.assert( _.routineIs( onDirectNeighbourNodesGet ), 'Direct neighbour nodes getter is not defined' );
  _.assert( _.routineIs( onReverseNeighbourNodesGet ), 'Reverse neighbour nodes getter is not defined' );

  group.onDirectNeighbourNodesGet = onReverseNeighbourNodesGet;
  group.onReverseNeighbourNodesGet = onDirectNeighbourNodesGet;

  group[ directSymbol ] = val;
  return group;
}

//

function cacheReverseFromDirectNeigbourNodes()
{
  let group = this;
  let nodes = group.nodes;

  _.assert( arguments.length === 0 );

  if( group.cahceOfReverseNeighbourNodesHash )
  return group;

  group.cahceOfReverseNeighbourNodesHash = new Map();
  group.nodes.forEach( ( nodeHandle1 ) =>
  {
    group.cahceOfReverseNeighbourNodesHash.set( nodeHandle1, new Array );
  });

  group.nodes.forEach( ( nodeHandle1 ) =>
  {
    let directNeighbours = group.nodeDirectNeigbourNodesGet( nodeHandle1 );
    directNeighbours.forEach( ( nodeHandle2 ) =>
    {
      let reverseNeighbours = group.cahceOfReverseNeighbourNodesHash.get( nodeHandle2 );
      _.assert( !!reverseNeighbours, 'Node is not on the list of the graph group' );
      reverseNeighbours.push( nodeHandle1 );
    });
  });

  return group;
}

//

function cachesInvalidate()
{
  let group = this;
  debugger;
  _.assert( 'not tested' );
  if( group.cahceOfReverseNeighbourNodesHash )
  group.cahceOfReverseNeighbourNodesHash.clear();
  group.cahceOfReverseNeighbourNodesHash = null;
  return group;
}

//

function exportData( o )
{
  let group = this;
  return group._exportData( o );
}

//

function _exportData( it )
{
  let group = this;
  let sys = group.sys;

  let result = Object.create( null );
  result.nodeHandles = group.nodesExportData( group.nodes );

  return result;
}

//

function exportInfo( o )
{
  let group = this;
  let sys = group.sys;
  let result = group.nodesExportInfo( group.nodes );
  return result;
}

//

function nodeDescriptorGet( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorGet.apply( sys, arguments );
}

//

function nodeDescriptorProduce( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorProduce.apply( sys, arguments );
}

// --
// nodeHandle
// --

function nodeHas( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ) );
  return _.arrayHas( group.nodes, nodeHandle );
}

//

function nodeIs( nodeHandle )
{
  let group = this;
  return group.onNodeIs( nodeHandle );
}

// --
// nodeHandle
// --

function nodeDirectNeigbourNodesGet( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ) );
  _.assert( arguments.length === 1 );
  let result = group.onDirectNeighbourNodesGet( nodeHandle );
  _.assert( _.arrayIs( result ) );
  return result;
}

//

function nodeReverseNeigbourNodesGet( nodeHandle )
{
  let group = this;
  _.assert( !!group.nodeIs( nodeHandle ) );
  _.assert( arguments.length === 1 );
  let result = group.onReverseNeighbourNodesGet( nodeHandle );
  _.assert( _.arrayIs( result ) );
  return result;
}

//

function nodeCount( nodeId )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 1 );
  _.assert( !!nodeId, 'Expects node or node id' );
  _.assert( 'not tested' );

  if( !sys.idIs( nodeId ) )
  {
    let nodeId2 = group.nodeToIdTry( nodeId );
    if( nodeId2 === undefined )
    {
      _.assert( !!group.nodeIs( nodeId ), 'Expects node or node id' );
      return 0;
    }
    nodeId = nodeId2;
  }

  let descriptor = group.nodeDescriptorGet( nodeId );

  if( !descriptor )
  if( sys.idToNodeHash.has( nodeId ) )
  return 1;
  else
  return 0;

  _.assert( result >= 0 );

  return result;
}

//

function nodesSet( nodes )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 1 );
  _.assert( nodes === null || _.arrayIs( nodes ) );

  group.nodesDelete( group.nodes.slice() );
  if( nodes )
  group.nodesAdd( nodes );

  return group.nodes;
}

//

function nodeAdd( nodeHandle )
{
  let group = this;
  let sys = group.sys;

  _.assert( !!group.nodeIs( nodeHandle ), 'Expects nodeHandle' );
  _.assert( !_.arrayHas( group.nodes, nodeHandle ), 'The group does not have a node with such nodeHandle' );
  _.arrayAppendOnceStrictly( group.nodes, nodeHandle );

  let wasDefined = true;
  let id = sys.nodeToIdHash.get( nodeHandle );
  if( id === undefined )
  {
    id = ++sys.nodeCounter;
    wasDefined = false;
  }

  sys.nodeToIdHash.set( nodeHandle, id );
  sys.idToNodeHash.set( id, nodeHandle );

  if( wasDefined )
  {
    let descriptor = sys.nodeDescriptorsHash.get( id );
    if( !descriptor )
    {
      descriptor = Object.create( null );
      descriptor.count = 2;
      sys.nodeDescriptorsHash.set( id, descriptor );
    }
    else
    {
      descriptor.count += 1;
    }
  }

  return id;
}

//

function nodeDelete( nodeHandle )
{
  let group = this;
  let sys = group.sys;
  let id = sys.nodeToIdHash.get( nodeHandle );
  let descriptor = group.nodeDescriptorGet( nodeHandle );

  _.assert( !!group.nodeIs( nodeHandle ), 'Expects nodeHandle' );
  _.assert( sys.nodeToIdHash.has( nodeHandle ), 'The system does not have a node with such nodeHandle' );
  _.assert( descriptor === undefined || descriptor.count > 0, 'The system does not have information about number of the node' );
  _.assert( _.arrayHas( group.nodes, nodeHandle ), 'The group does not have a node with such nodeHandle' );

  _.arrayRemoveOnceStrictly( group.nodes, nodeHandle );

  if( descriptor && descriptor.count > 1 )
  {
    descriptor.count -= 1;
  }
  else
  {
    sys.nodeToIdHash.delete( nodeHandle );
    sys.idToNodeHash.delete( id );
    sys.nodeDescriptorsHash.delete( id );
  }

  return id;
}

//

let _nodesDelete = _.vectorize( nodeDelete );
function nodesDelete()
{
  let group = this;
  if( arguments.length === 0 )
  return group.nodesDelete( group.nodes.slice() );
  return _nodesDelete.apply( this, arguments );
}

//

function nodeExportData( nodeHandle )
{
  let group = this;

  _.assert( group.nodeIs( nodeHandle ) );

  let result = Object.create( null );
  result.id = group.nodeToId( nodeHandle );
  result.neighbours = group.nodesToIdsTry( group.nodeDirectNeigbourNodesGet( nodeHandle ) );

  return result;
}

//

function nodeExportInfo( nodeHandle )
{
  let group = this;

  let data = group.nodeExportData( nodeHandle );
  let result = String( data.id ) + ' : ';

  result += data.neighbours.join( ' ' );

  return result;
}

//

function nodesExportInfo( nodes )
{
  let group = this;
  _.assert( arguments.length === 0 || arguments.length === 1 )
  nodes = nodes || group.nodes;
  let result = nodes.map( ( nodeHandle ) => group.nodeExportInfo( nodeHandle ) );
  result = result.join( '\n' );
  return result;
}

//

function nodeToName( nodeHandle )
{
  let group = this;
  let sys = group.sys;
  _.assert( _.routineIs( group.onNodeNameGet ), 'Graph group does not have defined onNodeNameGet to been able to get name' );
  _.assert( group.nodeIs( nodeHandle ), 'Expects node' );
  _.assert( arguments.length === 1 );
  return group.onNodeNameGet( nodeHandle );
}

//

function nodeToIdTry( nodeHandle )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeToIdTry( nodeHandle );
}

//

function nodeToId( nodeHandle )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeToId( nodeHandle );
}

//

function idToNodesTry( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.idToNodesTry( nodeId );
}

//

function idToNodes( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.idToNodes( nodeId );
}

// --
// algos
// --

function sinksAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( group.nodesAreAll( nodes ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let result = nodes.filter( ( node ) => group.nodesDirectNeigbourNodesGet( node ).length === 0 );

  return result;
}

//

function sourcesAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;

  _.assert( group.nodesAreAll( nodes ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onReverseNeighbourNodesGet )
  {
    group.onReverseNeighbourNodesGet = group.cahcedOnReverseNeighbourNodesGet;
    group.cacheReverseFromDirectNeigbourNodes();
  }

  let result = nodes.filter( ( node ) => group.nodeReverseNeigbourNodesGet( node ).length === 0 );

  return result;
}

//

function lookBfs( o )
{
  let group = this;

  o.nodes = _.arrayAs( o.nodes );

  _.assert( arguments.length === 1 );
  _.assert( group.nodesAreAll( o.nodes ) );
  _.routineOptions( lookBfs, o );

  let it = Object.create( null );
  it.visited = [];
  it.layers = [];
  it.layer = 0;
  it.continue = true;
  it.continueNode = true;
  it.result = it.layers;
  it.options = o;

  visit( o.nodes, it );

  return it.result;

  /* */

  function visit( nodes, it )
  {
    let nodes2 = [];
    let nodes3 = [];

    if( o.onUp )
    o.onUp( nodes, it );

    if( it.continue )
    nodes.every( ( nodeHandle ) =>
    {
      if( _.arrayHas( it.visited, nodeHandle ) )
      return true;
      if( o.onNode )
      o.onNode( nodeHandle, it );
      if( it.continueNode )
      {
        nodes2.push( nodeHandle );
        it.visited.push( nodeHandle );
      }
      it.continueNode = true;
      return it.continue;
    });

    if( nodes2.length )
    {

      it.layers.push( nodes2 );

      if( it.continue )
      {

        nodes2.every( ( nodeHandle ) =>
        {
          let neigbours = group.nodeDirectNeigbourNodesGet( nodeHandle );
          _.arrayAppendArray( nodes3, neigbours );
          return true;
        });

        it.layer += 1;
        visit( nodes3, it );

      }

    }

    if( o.onDown )
    o.onDown( nodes2, it );
  }

}

lookBfs.defaults =
{
  nodes : null,
  onUp : null,
  onDown : null,
  onNode : null,
}

//

function lookDfs( o )
{
  let group = this;

  o.nodes = _.arrayAs( o.nodes );

  _.routineOptions( lookDfs, o );
  _.assert( arguments.length === 1 );
  _.assert( group.nodesAreAll( o.nodes ) );

  let it = Object.create( null );
  it.visited = [];
  it.continue = true;
  it.continueUp = true;
  it.result = false;
  it.options = o;

  o.nodes.forEach( ( node ) => visit( node, it ) );

  return it.result;

  /* */

  function visit( nodeHandle, it )
  {

    // let id = group.nodeToId( nodeHandle );
    // if( _.arrayHas( it.visited, id ) )
    // return;
    // it.visited.push( id );

    if( _.arrayHas( it.visited, nodeHandle ) )
    return;
    it.visited.push( nodeHandle );

    if( o.onUp )
    o.onUp( nodeHandle, it );

    if( it.continue && it.continueUp )
    {
      let neigbours = group.nodeDirectNeigbourNodesGet( nodeHandle );
      for( let n = 0 ; n < neigbours.length ; n++ )
      {
        visit( neigbours[ n ], it );
        if( !it.continue )
        break;
      }
    }

    if( o.onDown )
    o.onDown( nodeHandle, it );

    it.continueUp = true;

  }

}

lookDfs.defaults =
{
  nodes : null,
  onUp : null,
  onDown : null,
}

//

function topologicalSortDfs( nodeHandles )
{
  let group = this;
  let ordering = [];
  let visited = [];

  if( nodeHandles === undefined )
  nodeHandles = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodeHandles ) );

  nodeHandles.forEach( ( nodeHandle ) =>
  {
    if( _.arrayHas( visited, nodeHandle ) )
    return;
    group.lookDfs({ nodes : nodeHandle, onDown : handleDown });
  });

  _.assert( ordering.length === nodeHandles.length );

  return ordering;

  /* */

  function handleDown( nodeHandle, it )
  {
    let neigbours = group.nodeDirectNeigbourNodesGet( nodeHandle );
    neigbours = neigbours.filter( ( nodeHandle2 ) => !_.arrayHas( visited, nodeHandle2 ) );
    if( neigbours.length === 0 )
    {
      ordering.push( nodeHandle );
    }
    visited.push( nodeHandle );
  }

}

//

function topologicalSortSourceBasedBfs( nodeHandles )
{
  let group = this;

  if( nodeHandles === undefined )
  nodeHandles = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let sources = group.sourcesAmong( nodeHandles );

  if( !sources.length )
  sources = nodeHandles;

  let result = group.lookBfs({ nodes : sources });

  return result;
}

// --
// connectivity algos
// --

function nodesAreConnectedDfs( handle1, handle2 )
{
  let group = this;

  _.assert( arguments.length === 2 );
  _.assert( !!group.nodeIs( handle1 ) );
  _.assert( !!group.nodeIs( handle2 ) );

  return group.lookDfs({ nodes : handle1, onUp : onUp });

  /* */

  function onUp( nodeHandle, it )
  {

    if( nodeHandle === handle2 )
    {
      it.continue = false;
      it.result = true;
    }

  }

}

//

function groupByConnectivityDfs( nodeHandles )
{
  let group = this;
  let groups = [];
  let visited = [];

  if( nodeHandles === undefined )
  nodeHandles = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodeHandles ) );

  nodeHandles.forEach( ( nodeHandle ) =>
  {
    let id = group.nodeToId( nodeHandle );
    if( _.arrayHas( visited, id ) )
    return;
    groups.push( [] );
    group.lookDfs({ nodes : nodeHandle, onUp : handleUp });
  });

  return groups;

  /* */

  function handleUp( nodeHandle, it )
  {
    let id = group.nodeToId( nodeHandle );
    visited.push( id );
    groups[ groups.length-1 ].push( id );
  }

}

//

function groupByStrongConnectivityDfs( nodeHandles )
{
  let group = this;
  let visited1 = [];
  let visited2 = [];
  let groups = [];

  group.reverse();

  if( nodeHandles === undefined )
  nodeHandles = group.nodes;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodeHandles ) );

  nodeHandles.forEach( ( nodeHandle ) =>
  {
    if( visited1.indexOf( nodeHandle ) !== -1 )
    return;
    group.lookDfs({ nodes : nodeHandle, onUp : handleUp1, onDown : handleDown1 });
  });

  group.reverse();

  for( let i = visited1.length-1 ; i >= 0 ; i-- )
  {
    let nodeHandle = visited1[ i ];
    if( visited2.indexOf( nodeHandle ) !== -1 )
    continue;
    groups.push( [] );
    group.lookDfs({ nodes : nodeHandle, onUp : handleUp2 });
  }

  return groups;

  /* */

  function handleUp1( nodeHandle, it )
  {
    if( visited1.indexOf( nodeHandle ) !== -1 )
    {
      it.continueUp = false;
      return;
    }
  }

  /* */

  function handleDown1( nodeHandle, it )
  {
    if( !it.continueUp )
    return;
    visited1.push( nodeHandle );
  }

  /* */

  function handleUp2( nodeHandle, it )
  {
    if( visited2.indexOf( nodeHandle ) !== -1 )
    {
      it.continueUp = false;
      return;
    }
    visited2.push( nodeHandle );
    groups[ groups.length - 1 ].push( nodeHandle );
  }

}

// --
// etc
// --

function defaultOnNodeName( nodeHandle )
{
  return nodeHandle.name;
}

//

function defaultOnNodeIs( nodeHandle )
{
  if( !_.objectIs( nodeHandle ) )
  return false;
  return _.maybe;
}

//

function defaultOnDirectNeighbourNodesGet( nodeHandle )
{
  let group = this;
  return nodeHandle.nodes;
}

//

function cahcedOnReverseNeighbourNodesGet( nodeHandle )
{
  let group = this;
  let neigbours = group.cahceOfReverseNeighbourNodesHash.get( nodeHandle );
  _.assert( _.arrayIs( neigbours ), 'No cache for the node' );
  return neigbours;
}

// --
// relations
// --

let nodesSymbol = Symbol.for( 'nodes' );
let directSymbol = Symbol.for( 'direct' );

let Composes =
{
  direct : true,
}

let Aggregates =
{
  onNodeNameGet : defaultOnNodeName,
  onNodeIs : defaultOnNodeIs,
  onDirectNeighbourNodesGet : defaultOnDirectNeighbourNodesGet,
  onReverseNeighbourNodesGet : null,
}

let Associates =
{
  sys : null,
  nodes : null,
}

let Restricts =
{
  cahceOfReverseNeighbourNodesHash : null,
}

let Statics =
{
}

let Accessors =
{
  nodes : {},
  direct : {},
}

// --
// declare
// --

let Extend =
{

  init,
  finit,
  form,
  unform,
  clone,

  // reverse

  directSet,
  reverse,
  cacheReverseFromDirectNeigbourNodes,
  cachesInvalidate,

  // export

  exportData,
  _exportData,
  exportInfo,

  // descriptor

  nodeDescriptorGet,
  nodeDescriptorProduce,

  // nodeHandle

  nodeHas,
  nodesHas : _.vectorize( nodeHas ),
  nodesHasAll : _.vectorizeAll( nodeHas ),
  nodesHasAny : _.vectorizeAny( nodeHas ),
  nodesHasNone : _.vectorizeNone( nodeHas ),

  nodeIs,
  nodesAre : _.vectorize( nodeIs ),
  nodesAreAll : _.vectorizeAll( nodeIs ),
  nodesAreAny : _.vectorizeAny( nodeIs ),
  nodesAreNone : _.vectorizeNone( nodeIs ),

  nodeDirectNeigbourNodesGet,
  nodesDirectNeigbourNodesGet : _.vectorize( nodeDirectNeigbourNodesGet ),
  nodeReverseNeigbourNodesGet,
  nodesReverseNeigbourNodesGet : _.vectorize( nodeReverseNeigbourNodesGet ),
  nodeCount,
  nodesSet,

  nodeAdd,
  nodesAdd : _.vectorize( nodeAdd ),
  nodeDelete,
  nodesDelete,

  nodeExportData,
  nodesExportData : _.vectorize( nodeExportData ),
  nodeExportInfo,
  nodesExportInfo,

  nodeToName,
  nodesToNames : _.vectorize( nodeToName ),
  nodeToIdTry,
  nodesToIdsTry : _.vectorize( nodeToIdTry ),
  nodeToId,
  nodesToIds : _.vectorize( nodeToId ),
  idToNodesTry,
  idsToNodesTry : _.vectorize( idToNodesTry ),
  idToNodes,
  idsToNodes : _.vectorize( idToNodes ),

  // algos

  sinksAmong,
  sourcesAmong,

  lookBfs,
  lookDfs,
  look : lookDfs,

  topologicalSortDfs,
  topologicalSort : topologicalSortDfs,
  topologicalSortSourceBasedBfs,
  topologicalSortSourceBased : topologicalSortSourceBasedBfs,

  // connectivity algos

  nodesAreConnectedDfs,
  nodesAreConnected : nodesAreConnectedDfs,
  groupByConnectivityDfs,
  groupByConnectivity : groupByConnectivityDfs,
  groupByStrongConnectivityDfs,
  groupByStrongConnectivity : groupByStrongConnectivityDfs,

  // default

  defaultOnNodeName,
  defaultOnNodeIs,
  defaultOnDirectNeighbourNodesGet,
  cahcedOnReverseNeighbourNodesGet,

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_[ Self.shortName ] = Self;

})();
