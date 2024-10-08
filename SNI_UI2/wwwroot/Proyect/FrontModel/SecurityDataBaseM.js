import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";

class Security_Permissions extends EntityClass {
   constructor(props) {
       super(props, 'EntitySECURITY');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   Id_Permission = { type: 'number', primary: true };
   Descripcion = { type: 'text' };
   Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
}
export { Security_Permissions }
class Security_Permissions_Roles extends EntityClass {
   constructor(props) {
       super(props, 'EntitySECURITY');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
}
export { Security_Permissions_Roles }
class Security_Roles extends EntityClass {
   constructor(props) {
       super(props, 'EntitySECURITY');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   Id_Role = { type: 'number', primary: true };
   Descripcion = { type: 'text' };
   Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
}
export { Security_Roles }
class Security_Users extends EntityClass {
   constructor(props) {
       super(props, 'EntitySECURITY');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   Id_User = { type: 'number', primary: true };
   Nombres = { type: 'text' };
   Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   Descripcion = { type: 'text' };
   Password = { type: 'text' };
   Mail = { type: 'text' };
   Token = { type: 'text' };
   Token_Date = { type: 'date' };
   Token_Expiration_Date = { type: 'date' };
}
export { Security_Users }
class Security_Users_Roles extends EntityClass {
   constructor(props) {
       super(props, 'EntitySECURITY');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
}
export { Security_Users_Roles }
