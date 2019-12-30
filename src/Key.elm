module Key exposing (Key, isInKey, keyName, makeKey, rootTone)

import Note exposing (Modifier, Note(..), NoteLetter, Tone)
import Scale exposing (Scale)


type Key
    = Key NoteLetter Modifier Scale


makeKey : NoteLetter -> Modifier -> Scale -> Key
makeKey =
    Key


keyName : Key -> String
keyName (Key n m s) =
    Note.noteLetterToString n ++ Note.modifierToString m ++ " " ++ Scale.scaleName s


rootTone : Key -> Tone
rootTone (Key l m _) =
    Note.toTone (Note l m 4)


isInKey : Key -> Tone -> Bool
isInKey key tone =
    let
        (Key _ _ s) =
            key
    in
    Scale.isSemitoneDegreeInScale s (Note.semitoneDegree (rootTone key) tone)
