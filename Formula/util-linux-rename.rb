require 'formula'

class UtilLinuxRename < Formula
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  url      'https://www.kernel.org/pub/linux/utils/util-linux/v2.30/util-linux-2.30.tar.xz'
  sha256   'c208a4ff6906cb7f57940aa5bc3a6eed146e50a7cc0a092f52ef2ab65057a08d'

  depends_on 'pkg-config' => :build

  def install
    system './configure', '--disable-dependency-tracking', "--prefix=#{prefix}"
    system 'make', 'rename'
    bin.install 'rename'
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # 'false' with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test util-linux`.
    system 'false'
  end
end

