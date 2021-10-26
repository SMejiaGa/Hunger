//
//  Lang.swift
//  Hunger
//
//  Created by Sebastian Mejia on 18/10/21.
//

import Foundation

struct Lang {
    struct Main {
        static let notAvailableError = "La opcion no esta disponible en este momento"
    }
    
    struct Login {
        static let invalidEmailMessage = "invalid email"
    }
    
    struct Recovery {
        static let alertMessage = "Se ha enviado un email de confirmacion a su correo"
        static let errorMessage = "Debe ingresar un correo"
    }
    
    struct Register {
        static let alertMeesage = "debe registrar un email valido y su contrasenia debe ser mayor a 3 caracteres"
    }
}
