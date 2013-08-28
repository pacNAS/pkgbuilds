#!/usr/bin/bash



##
#  usage : in_array( $needle, $haystack )
# return : 0 - found
#          1 - not found
##
in_array() {
  local needle=$1; shift
  local item
  for item in "$@"; do
    [[ $item = "$needle" ]] && return 0 # Found
  done
  return 1 # Not Found
}


repo=*
pkg=*

pkgnames=()
depends_array=()
makedepends_array=()
checkdepends_array=()
optdepends_array=()

for file in ./${repo}/${pkg}/PKGBUILD
do
  source ${file}

  pkgnames=(${pkgnames[@]} ${pkgname[@]})
  pkgnames=(${pkgnames[@]} ${provides[@]})

  depends_array=(${depends_array[@]} ${depends[@]})
  makedepends_array=(${makedepends_array[@]} ${makedepends[@]})
  checkdepends_array=(${checkdepends_array[@]} ${checkdepends[@]})

  optdepends_list=()
  eval $(awk '/^[[:space:]]*optdepends=\(/,/\)[[:space:]]*(#.*)?$/' "$file" | \
    sed -e "s/optdepends=/optdepends_list+=/" -e "s/#.*//" -e 's/\\$//')
  for i in "${optdepends_list[@]}"; do
    pkg=${i%%:[[:space:]]*}
    optdepends_array=(${optdepends_array[@]} $pkg)
    # the '-' character _must_ be first or last in the character range
    if [[ $pkg != +([-[:alnum:]><=.+_:]) ]]; then
      error "$(gettext "Invalid syntax for %s : '%s'")" "optdepend" "$i"
      ret=1
    fi
    echo package: $pkg
  done

  unset depends makedepends optdepends checkdepends pkgname provides pkg

done

echo packages: ${pkgnames[@]}

for package in ${pkgnames[@]}
do
  depends_array=(${depends_array[@]/$package/})
  makedepends_array=(${makedepends_array[@]/$package/})
  checkdepends_array=(${checkdepends_array[@]/$package/})
  optdepends_array=(${optdepends_array[@]/$package/})
done

echo depends: ${depends_array[@]}
echo makedepends: ${makedepends_array[@]}
echo checkdepends: ${checkdepends_array[@]}
echo optdepends: ${optdepends_array[@]}