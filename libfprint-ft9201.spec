%define hwmodel  ft9201
%define srcname  libfprint
%define soname   %{srcname}-2.so.2
%define rulename 60-%{srcname}-2.rules

Name:           %{srcname}-%{hwmodel}
Vendor:         RheaAyase
Version:        1.94.6
Release:        1.fc40
Summary:        Patched version of %{srcname}
License:        MIT & FocalSystems
URL:            https://github.com/%{vendor}/%{srcname}-%{hwmodel}

Source0:        https://kojipkgs.fedoraproject.org/packages/%{srcname}/%{version}/%{release}/%{_arch}/%{srcname}-%{version}-%{release}.%{_arch}.rpm
Source1:        %{url}/raw/main/%{srcname}-2-tod.so.1
Source2:        %{url}/raw/main/%{rulename}

BuildRequires:  cpio rpm
Provides:       %{soname}()(%{__isa_bits}bit)
Provides:       %{soname}(LIBFPRINT_2.0.0)(%{__isa_bits}bit)

%description
Patched version of %{srcname} to support the %{hwmodel} fingerprint driver

%prep
rm -rf %{buildroot}

%install
rpm2cpio %{SOURCE0} | cpio -idum --directory %{buildroot}
install -Dm755 %{SOURCE1} %{buildroot}/%{_libdir}/%{soname}.0.0
install -Dm644 %{SOURCE2} %{buildroot}/%{_prefix}/lib/udev/rules.d/%{rulename}

%files
%{_datadir}/licenses/%{srcname}
%{_libdir}/%{srcname}-2-tod.so.1
%{_libdir}/%{soname}
%{_libdir}/%{soname}.0.0
%{_libdir}/girepository-1.0/*.typelib
%{_prefix}/lib/.build-id/*/*
%{_prefix}/lib/udev/hwdb.d/*.hwdb
%{_prefix}/lib/udev/rules.d/*.rules
%{_docdir}/%{srcname}

%changelog
* Fri Feb 16 2024 Rhea Gustavsson <domme@rhea.dev> - 0.1
- Created the package

