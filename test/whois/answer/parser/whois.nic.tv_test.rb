require 'test_helper'
require 'whois/answer/parser/whois.nic.tv'

class AnswerParserWhoisNicTvTest < Whois::Answer::Parser::TestCase

  def setup
    @klass  = Whois::Answer::Parser::WhoisNicTv
    @host   = "whois.nic.tv"
  end


  def test_disclaimer
    expected = <<-EOS.strip
TERMS OF USE: You are not authorized to access or query our Whois \
database through the use of electronic processes that are high-volume and \
automated except as reasonably necessary to register domain names or \
modify existing registrations; the Data in VeriSign's ("VeriSign") Whois \
database is provided by VeriSign for information purposes only, and to \
assist persons in obtaining information about or related to a domain name \
registration record. VeriSign does not guarantee its accuracy. \
By submitting a Whois query, you agree to abide by the following terms of \
use: You agree that you may use this Data only for lawful purposes and that \
under no circumstances will you use this Data to: (1) allow, enable, or \
otherwise support the transmission of mass unsolicited, commercial \
advertising or solicitations via e-mail, telephone, or facsimile; or \
(2) enable high volume, automated, electronic processes that apply to \
VeriSign (or its computer systems). The compilation, repackaging, \
dissemination or other use of this Data is expressly prohibited without \
the prior written consent of VeriSign. You agree not to use electronic \
processes that are automated and high-volume to access or query the \
Whois database except as reasonably necessary to register domain names \
or modify existing registrations. VeriSign reserves the right to restrict \
your access to the Whois database in its sole discretion to ensure \
operational stability.  VeriSign may restrict or terminate your access to the \
Whois database for failure to abide by these terms of use. VeriSign \
reserves the right to modify these terms at any time. 
EOS

    parser    = @klass.new(load_part('/registered.txt'))
    assert_equal  expected, parser.disclaimer
    assert_equal  expected, parser.instance_eval { @disclaimer }

    parser    = @klass.new(load_part('/available.txt'))
    assert_equal  expected, parser.disclaimer
    assert_equal  expected, parser.instance_eval { @disclaimer }
  end


  def test_domain
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = "thinkcode.tv"
    assert_equal  expected, parser.domain
    assert_equal  expected, parser.instance_eval { @domain }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = "u34jedzcq.tv"
    assert_equal  expected, parser.domain
    assert_equal  expected, parser.instance_eval { @domain }
  end

  def test_domain_id
    assert_raise(Whois::PropertyNotSupported) { @klass.new(load_part('/registered.txt')).domain_id }
    assert_raise(Whois::PropertyNotSupported) { @klass.new(load_part('/available.txt')).domain_id }
  end


  def test_referral_whois
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = "whois.dynadot.com"
    assert_equal  expected, parser.referral_whois
    assert_equal  expected, parser.instance_eval { @referral_whois }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = nil
    assert_equal  expected, parser.referral_whois
    assert_equal  expected, parser.instance_eval { @referral_whois }
  end

  def test_referral_url
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = "http://www.dynadot.com"
    assert_equal  expected, parser.referral_url
    assert_equal  expected, parser.instance_eval { @referral_url }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = nil
    assert_equal  expected, parser.referral_url
    assert_equal  expected, parser.instance_eval { @referral_url }
  end


  def test_status
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = "CLIENT-XFER-PROHIBITED"
    assert_equal  expected, parser.status
    assert_equal  expected, parser.instance_eval { @status }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = nil
    assert_equal  expected, parser.status
    assert_equal  expected, parser.instance_eval { @status }
  end

  def test_available?
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = false
    assert_equal  expected, parser.available?
    assert_equal  expected, parser.instance_eval { @available }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = true
    assert_equal  expected, parser.available?
    assert_equal  expected, parser.instance_eval { @available }
  end

  def test_registered?
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = true
    assert_equal  expected, parser.registered?
    assert_equal  expected, parser.instance_eval { @registered }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = false
    assert_equal  expected, parser.registered?
    assert_equal  expected, parser.instance_eval { @registered }
  end


  def test_created_on
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = Time.parse("2009-04-21")
    assert_equal  expected, parser.created_on
    assert_equal  expected, parser.instance_eval { @created_on }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = nil
    assert_equal  expected, parser.created_on
    assert_equal  expected, parser.instance_eval { @created_on }
  end

  def test_updated_on
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = Time.parse("2009-11-19")
    assert_equal  expected, parser.updated_on
    assert_equal  expected, parser.instance_eval { @updated_on }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = nil
    assert_equal  expected, parser.updated_on
    assert_equal  expected, parser.instance_eval { @updated_on }
  end

  def test_expires_on
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = Time.parse("2010-04-21")
    assert_equal  expected, parser.expires_on
    assert_equal  expected, parser.instance_eval { @expires_on }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = nil
    assert_equal  expected, parser.expires_on
    assert_equal  expected, parser.instance_eval { @expires_on }
  end


  def test_registrar
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = nil
    assert_equal  expected, parser.registrar
    assert_equal  expected, parser.instance_eval { @registrar }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = nil
    assert_equal  expected, parser.registrar
    assert_equal  expected, parser.instance_eval { @registrar }
  end


  def test_nameservers
    parser    = @klass.new(load_part('/registered.txt'))
    expected  = %w( ns1.slicehost.net ns2.slicehost.net )
    assert_equal  expected, parser.nameservers
    assert_equal  expected, parser.instance_eval { @nameservers }

    parser    = @klass.new(load_part('/available.txt'))
    expected  = %w()
    assert_equal  expected, parser.nameservers
    assert_equal  expected, parser.instance_eval { @nameservers }
  end

end
