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
        static let invalidLogIn = "Incorrect, please try again"
    }
    
    struct Recovery {
        static let alertMessage = "Se ha enviado un email de confirmacion a su correo"
        static let errorMessage = "Debe ingresar un correo"
    }
    
    struct Register {
        static let alertMessage = "debe registrar un email valido y su contraseña debe ser mayor a 3 caracteres"
        static let errorMessage = "El email registrado ya se encuentra asociado a una cuenta"
        static let succesMessage = "Bienvenido a hungry!"
        
    }
    
    struct List{
        static let chooseAnOptionMessage = "Elige una opcion"
        static let showMapLabelMessage = "Mostrar mapa"
        static let aboutUsMessage = "Sobre nosotros"
        static let cancelMessage = "Cancelar"
    }
    
    struct ErrorMessages {
        static let tryAgainLaterError = "Ocurrio un error, Intentalo de nuevo mas tarde"
    }
}
