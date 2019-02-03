( function _UseAbstractMid_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( './UseAbstractBase.s' );

  require( './l1/AbstractGroup.s' );
  require( './l1/AbstractSystem.s' );

}

//

let _ = _global_.wTools;
let Self = _global_.wTools.graph = _global_.wTools.graph || Object.create( null );

//

})();
