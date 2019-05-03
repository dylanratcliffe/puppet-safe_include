require 'spec_helper_acceptance'

describe 'checking class existence' do
  context 'when a class exists' do
    pp = <<-PUPPETCODE
      $return = safe_include::class_exists('postgresql::server')

      file { '/result':
        ensure  => file,
        content => $return,
      }
    PUPPETCODE

    idempotent_apply(pp)

    expect('/result').to be_file
    expect('/result').to contain 'true'  
  end

  context 'when a class doesn\'t exist' do
    pp = <<-PUPPETCODE
      $return = safe_include::class_exists('postgresql::alkdjncsjkdncksdubc')

      file { '/result':
        ensure  => file,
        content => $return,
      }
    PUPPETCODE

    idempotent_apply(pp)

    expect('/result').to be_file
    expect('/result').to contain 'false'  
  end
end

# describe 'safe_include' do
#   context 'when ' do
#     it do
#       test_motd(pp_static_content, "Hello world!\n", motd_file)
#     end
#   end

#   context 'when static message from template' do
#     it do
#       test_motd(pp_static_template, template_expected_content, motd_file)
#     end
#   end

#   context 'when static message from content in /etc/issue' do
#     it do
#       test_motd(pp_static_content_issue, "Hello world!\n", issue_file)
#     end
#   end

#   context 'when static message from template in /etc/issue' do
#     it do
#       test_motd(pp_static_template_issue, template_expected_content, issue_file)
#     end
#   end

#   context 'when static message from content in /etc/issue.net' do
#     it do
#       test_motd(pp_static_content_issue_net, "Hello world!\n", issue_net_file)
#     end
#   end

#   context 'when static message from template in /etc/issue.net' do
#     it do
#       test_motd(pp_static_template_issue_net, template_expected_content, issue_net_file)
#     end
#   end

#   context 'when disable dynamic motd settings on Debian', if: os[:family] == 'debian' do
#     it do
#       test_motd(pp_debian_dynamic, "Hello world!\n", motd_file)
#     end
#     describe file('/etc/pam.d/sshd') do
#       its(:content) { is_expected.not_to match %r{session    optional     pam_motd.so  motd=/run/motd.dynamic} }
#     end
#   end
# end