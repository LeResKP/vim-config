if exists("b:status_bar_func")
  finish
endif

function! GetCurrentPythonStringForStatusBar()
  " TODO: support: if __name__ == '__main__':

  " Define the style to display the class name and function name
  let classHi = '%#statusbar_red#'
  let functionHi = '%#statusbar_blue#'
  let punctuationHi = '%#statusbar#'

  " Search the first class method definition before the current position
  let classFunctionLineNumber = search('^    def', 'bncW')

  " Search the first function definition before the current position
  let simpleFunctionLineNumber = search('^def', 'bncW')

  " Search the first class definition before the current position
  let classLineNumber = search('^class', 'bncW')


  let className = classHi.substitute(getline(classLineNumber), '^class \([^(: ]*\).*', '\1', '')

  if classFunctionLineNumber < classLineNumber && simpleFunctionLineNumber < classLineNumber
    " We have found in first a class definition so we only return it
    return className
  endif

  if classFunctionLineNumber < simpleFunctionLineNumber
    " the function definition is found before the a method so we only return the function name
    return functionHi.substitute(getline(simpleFunctionLineNumber), '^[ ]*def \([^( ]*\).*', '\1', '')
  endif

  " return the class and the function name
  return className.punctuationHi.'.'.functionHi.substitute(getline(classFunctionLineNumber), '^[ ]*def \([^( ]*\).*', '\1', '')

endfunction

let b:status_bar_func=funcref#Function('GetCurrentPythonStringForStatusBar')
