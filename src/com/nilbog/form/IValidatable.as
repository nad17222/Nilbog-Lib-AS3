package com.nilbog.form
{

    /**
     * Interface for anything that can be either valid or invalid.
     * 
     * @author Mark Hawley
     */
    public interface IValidatable 
    {
        function validate():Boolean;
    }
}
