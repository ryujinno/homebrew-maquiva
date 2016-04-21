require 'formula'

class UtilLinuxRename < Formula
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  url      'http://www.kernel.org/pub/linux/utils/util-linux/v2.28/util-linux-2.28.tar.xz'
  sha256   '395847e2a18a2c317170f238892751e73a57104565344f8644090c8b091014bb'

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

